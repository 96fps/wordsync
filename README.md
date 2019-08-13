# wordsync
time-remap audio files using sox.

## Usage
`./remap.sh input.wav mapping.csv [output.wav]`
./remap.sh expects a WAV file, a mapping file, and optionally an output filename. The default is to write to out.wav in the current directory.

The mapping file is csv with each row being a new segment. Columns 2 & 3 describe start/end timestamp of each snippet in the original audio file, columns 3 & 4 denote the remapped target times for the output file.

### Example
The merge.sh to generate a compliant mapping file from two .CSV outputs generated by [gentle](https://github.com/lowerquality/gentle).
`./merge.sh sample/allstar/align.csv sample/allstar-gtts/align.csv > merge.csv`

use remap.sh to 
`./remap.sh sample/input2.wav merge.csv`