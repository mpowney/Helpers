import { fileTypeFromFile } from 'file-type';
import fs from 'fs';
import wf from 'wavefile';

var filename = process.argv[2]
// console.log(filename);
const fileType = await fileTypeFromFile(filename);
const fileStats = fs.statSync(filename);

const WaveFile = wf.WaveFile;
// const wav = new WaveFile();
try {
    let wav = new WaveFile(fs.readFileSync(filename));
    wav.toSampleRate(22050, { method: 'point', LPF: false })
    console.log({ filename, size: fileStats.size, isWave: true, ...fileType });
}
catch {
    console.log({ filename, size: fileStats.size, isWave: false, ...fileType });
}
// console.log(wav.toSampleRate(44100))
// console.log(wav.getSamples());
// fs.readFile(filename, (err, data) => {
//     wav.fromBuffer(data);
    
// });
