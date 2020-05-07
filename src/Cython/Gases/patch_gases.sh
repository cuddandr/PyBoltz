#!/bin/bash

PATCH_FILE=gas.patch

PATCH_TEXT='18c18
<     gd = np.load(os.path.join(os.path.dirname(os.path.realpath(__file__)),"gases.npy")).item()
---
>     gd = np.load(os.path.join(os.path.dirname(os.path.realpath(__file__)),"gases.npy"), allow_pickle=True).item()'

echo "$PATCH_TEXT" > $PATCH_FILE

echo "Using $PATCH_FILE"
for FILE in *.pyx; do
    echo "Patching $FILE ..."
    patch $FILE $PATCH_FILE
done

rm $PATCH_FILE
