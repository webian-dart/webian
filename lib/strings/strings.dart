

class Strings {
    static String capitalize(String s) =>
        s.isEmpty ? "" : s[0].toUpperCase() + s.substring(1);
    
    static bool toBoolean(String s)
        => s != null && s.toLowerCase() == "true";
}