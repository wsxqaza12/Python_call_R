#!/bin/sh

for file in /dependent/*; do
	echo "Install custom R package $file"
	R CMD INSTALL $file
done
