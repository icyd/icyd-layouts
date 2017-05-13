#!/bin/sh
set +x -e

# if argument given, normalize and use as root directory
[ -d "$1" ] && XKB_ROOT=$(readlink -f $1) || XKB_ROOT=/usr/share/X11/xkb

# check that these programs are available
which grep     1>/dev/null 2>&1 || exit 1
which sed      1>/dev/null 2>&1 || exit 2
which awk      1>/dev/null 2>&1 || exit 3
which xsltproc 1>/dev/null 2>&1 || exit 4

# some installations has an evdev in addition to a base rule
BASES=base
[ -e $XKB_ROOT/rules/evdev ] && BASES="$BASES evdev" || /bin/true
for base in $BASES; do

# see <http://www.grymoire.com/Unix/Sed.html#uh-40> for a tutorial
# all changes are prefixed by a guard to ensure indempotency
grep -c 'dvp[\ \t]*es:' $XKB_ROOT/rules/$base.lst 1>/dev/null || \
sed -i '
/\!\ variant/a\
  icyd             es: Spanish (IcyD Dvorak)
' $XKB_ROOT/rules/$base.lst

# insert fragment in the appropriate place, otherwise preserving the original
# document as-is. style to a temporary file and afterwards overwrite the target
# (removing the temporary file in the process). the awk command is for stripping
# the final newline character.
COUNT=$(grep -c "<description>Spanish (IcyD Dvorak)</description>" $XKB_ROOT/rules/$base.xml) || true
if [ $COUNT -eq 0 ]; then
TMP_FILE=$(mktemp $XKB_ROOT/rules/$base.xml.XXXXXX)
chmod 644 $TMP_FILE && \
xsltproc --nodtdattr --novalid - $XKB_ROOT/rules/$base.xml <<- __END__ | \
awk 'NR > 1 { print h } { h = $0 } END { ORS = ""; print h }' > $TMP_FILE && \
mv -f $TMP_FILE $XKB_ROOT/rules/$base.xml || \
rm $TMP_FILE
<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding="UTF-8" doctype-system="xkb.dtd"/>
<xsl:template match="xkbConfigRegistry/layoutList/layout/variantList[preceding-sibling::configItem/name='es']">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
    <xsl:text disable-output-escaping="yes"><![CDATA[  <variant>
          <configItem>
            <name>icyd</name>
            <description>Spanish (IcyD Dvorak)</description>
          </configItem>
        </variant>
      ]]></xsl:text>
  </xsl:copy>
</xsl:template>
<xsl:template match="/ | @* | node() ">
  <xsl:copy><xsl:apply-templates select="@* | node()" /></xsl:copy>
</xsl:template>
</xsl:stylesheet>
__END__
fi
done # bases

# append an inclusion to the relevant files. the data itself is
# stored in separate files so that removal is easier for the scripts.
grep -c 'xkb_symbols[\ \t]*"dvp"' $XKB_ROOT/symbols/es 1>/dev/null || \
cat <<- __END__ >> $XKB_ROOT/symbols/es
partial alphanumeric_keys xkb_symbols "icyd" { include "icyd" };
__END__
