// ~readTextFileFunction = {
// 	arg path;
// 	TabFileReader.read(~trace +/+  "explanatory_texts/" ++ path).flatten.asString.drop(2).drop(-2)
// };
//
// FileReader.read(path:~trace +/+ "explanatory_texts/tuning/tuningIntro.txt", delimiter:"");
//
//
// (
// ("Hello \n World").postln;
// )
//
// " "
//
//
// File.open(pathName:~trace +/+ "explanatory_texts/tuning/tuningIntro.txt", mode: "r").readAllString

~readTextFileFunction = {
	arg path;
	File.open(pathName:~trace +/+ "explanatory_texts/" ++ path, mode: "r").readAllString

};