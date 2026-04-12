package com.example.app.util;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.nio.file.Path;
import java.nio.file.Paths;

import org.junit.jupiter.api.Test;

public class FileUtilsTest {

	@Test
	public void testFirstLine() throws Exception {
		Path path = Paths.get(getClass().getClassLoader().getResource("com/example/app/util/utf8.txt").toURI());
		String firstLine = FileUtils.readFirstLine(path);

		assertEquals(firstLine, "（株）テスト");
	}

}
