function pad (str, char, max) {
  str = str.toString();
  return str.length < max ? pad(char + str, char, max) : str;
}