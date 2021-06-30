#!/bin/sh

# options
DIRECTORY_PATH=${1}
SKIP_PACK_ICON=${2}
STRICT_ZIP_SPEC_COMPLIANCE=${3}
COMPRESS_ALREADY_COMPRESSED_FILES=${4}
IGNORE_SYSTEM_AND_HIDDEN_FILES=${5}
ALLOW_MOD_OPTIFINE=${6}
ALLOW_MODS="["
if [ $ALLOW_MOD_OPTIFINE = "true" ]; then
    ALLOW_MODS=$ALLOW_MODS"\"OptiFine\""
fi
ALLOW_MODS=$ALLOW_MODS"]"
SAMPLING_FREQUENCY=${7}
TARGET_PITCH=${8}
MINIMUM_BITRATE=${9}
MAXIMUM_BITRATE=${10}
QUANTIZE_IMAGE=${11}
OUTPUT=${12}

# print version
packsquash --version

# generate settings
echo '
resource_pack_directory = '$DIRECTORY_PATH'
skip_pack_icon = '$SKIP_PACK_ICON'
strict_zip_spec_compliance = '$STRICT_ZIP_SPEC_COMPLIANCE'
compress_already_compressed_files = '$COMPRESS_ALREADY_COMPRESSED_FILES'
ignore_system_and_hidden_files = '$IGNORE_SYSTEM_AND_HIDDEN_FILES'
allowed_mods = '$ALLOW_MODS'
output_file_path = '$OUTPUT'

["assets/*/sounds/{music,ambience}/?*.{og[ga],mp3,wav,flac}"]
sampling_frequency = '$SAMPLING_FREQUENCY'
minimum_bitrate = '$MINIMUM_BITRATE'
maximum_bitrate = '$MAXIMUM_BITRATE'

["**/*.png"]
quantize_image = '$QUANTIZE_IMAGE'
' > packsquash-settings.toml

cat packsquash-settings.toml
