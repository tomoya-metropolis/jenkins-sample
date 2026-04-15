package com.example.app.util;

import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public final class FileUtils {

	private FileUtils() {
	}

	public static String readFirstLine(Path path) throws IOException {
		return readFirstLine(path, StandardCharsets.UTF_8);
	}

	public static String readFirstLine(Path path, Charset charset) throws IOException {
		List<String> lines = Files.readAllLines(path, charset);

		return lines.get(0);
	}

}
