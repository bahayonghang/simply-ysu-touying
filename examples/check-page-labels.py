"""Check the page labels and page sizes of a compiled YSU deck.

Usage:
    python -I examples/check-page-labels.py deck.pdf [--expect-notes]

With --expect-notes the deck must follow the FerroStage / pympress contract:
content pages labelled N (subslides of one frame share N), each frame
followed by one notes page labelled notes:N, content pages 16:9 or 4:3 and
notes pages 16:13.5 of the same width. Without it the deck must have no
notes pages. Exits with 1 on a violation. Standard library only: Typst
writes the catalog, page and label dictionaries uncompressed.
"""

import re
import sys

OBJ = re.compile(rb"(\d+) 0 obj(.*?)endobj", re.S)
REF = rb"(\d+) 0 R"


def load(path):
    data = open(path, "rb").read()
    return {int(m.group(1)): m.group(2) for m in OBJ.finditer(data)}


def ref(obj, key):
    m = re.search(rb"/" + key + rb"\s*" + REF, obj)
    return int(m.group(1)) if m else None


def pages(objs, node):
    """Page objects in document order, following /Kids."""
    obj = objs[node]
    kids = re.search(rb"/Kids\s*\[([^\]]*)\]", obj)
    if kids is None:
        return [obj]
    out = []
    for k in re.findall(REF, kids.group(1)):
        out += pages(objs, int(k))
    return out


def media_box(obj):
    m = re.search(rb"/MediaBox\s*\[([^\]]*)\]", obj)
    x0, y0, x1, y1 = (float(v) for v in m.group(1).split())
    return x1 - x0, y1 - y0


def pdf_string(raw):
    return raw.decode("latin-1").replace("\\(", "(").replace("\\)", ")")


def labels(objs, catalog, count):
    """Page labels as strings; None when the PDF has no /PageLabels."""
    root = ref(catalog, b"PageLabels")
    if root is None:
        return None
    nums = re.search(rb"/Nums\s*\[(.*)\]", objs[root], re.S).group(1)
    ranges = []
    for start, body in re.findall(rb"(\d+)\s+(\d+ 0 R|<<.*?>>)", nums, re.S):
        if body.endswith(b"R"):
            body = objs[int(body.split()[0])]
        prefix = re.search(rb"/P\s*\((.*?)(?<!\\)\)", body, re.S)
        st = re.search(rb"/St\s+(\d+)", body)
        style = re.search(rb"/S\s*/(\w)", body)
        ranges.append((
            int(start),
            pdf_string(prefix.group(1)) if prefix else "",
            int(st.group(1)) if st else 1,
            style is not None,
        ))
    out = []
    for i in range(count):
        start, prefix, st, numbered = max(r for r in ranges if r[0] <= i)
        out.append(prefix + (str(st + i - start) if numbered else ""))
    return out


def check(path, expect_notes):
    objs = load(path)
    catalog = next(o for o in objs.values() if re.search(rb"/Type\s*/Catalog", o))
    page_objs = pages(objs, ref(catalog, b"Pages"))
    sizes = [media_box(p) for p in page_objs]
    names = labels(objs, catalog, len(page_objs))
    errors = []

    print(f"{path}: {len(page_objs)} pages")
    if names is None:
        names = [str(i + 1) for i in range(len(page_objs))]
        print("labels: (none)")
    else:
        print("labels:", ", ".join(names))

    is_note = [n.startswith("notes:") for n in names]
    if not expect_notes:
        if any(is_note):
            errors.append("notes pages found, but --expect-notes is not set")
    else:
        frames = 0
        for i, (name, (w, h)) in enumerate(zip(names, sizes)):
            if is_note[i]:
                frames += 1
                prev = names[i - 1] if i > 0 else None
                if prev is None or is_note[i - 1] or name != "notes:" + prev:
                    errors.append(f"page {i + 1}: {name} does not follow content page {prev}")
                if abs(h / w - 13.5 / 16) > 1e-3:
                    errors.append(f"page {i + 1}: notes page {w:.1f}x{h:.1f} is not 16:13.5")
                if i > 0 and abs(w - sizes[i - 1][0]) > 0.1:
                    errors.append(f"page {i + 1}: notes page width differs from its slide")
            else:
                if i + 1 < len(names) and not is_note[i + 1] and names[i + 1] != name:
                    errors.append(f"page {i + 1}: frame {name} has no notes page")
                if min(abs(h / w - 9 / 16), abs(h / w - 9 / 12)) > 1e-3:
                    errors.append(f"page {i + 1}: content page {w:.1f}x{h:.1f} is not 16:9 or 4:3")
        if not is_note[-1]:
            errors.append("the last page is not a notes page")
        print(f"frames: {frames}, notes pages: {sum(is_note)}")

    for e in errors:
        print("ERROR:", e)
    return not errors


if __name__ == "__main__":
    args = sys.argv[1:]
    expect = "--expect-notes" in args
    files = [a for a in args if a != "--expect-notes"]
    if len(files) != 1:
        sys.exit(__doc__)
    sys.exit(0 if check(files[0], expect) else 1)
