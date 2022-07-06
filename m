Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432052F21
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 22:21:28 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id 145so15134101pga.12
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fubeP8Gpomxz1l4RpRKR7xeHEl2tknsqcnZNF0g+uDU=;
        b=lKXKzJNvKZ9qgkKYlZ5Jf3iXgLWWl/gXb3UAtf9gIdo/X3VPLShQQSgaUAwl5k2wNd
         A2fCsQ2xzA8BPmLI//r7vfig4lIv4zlwMjEPGaJlXuw2svVjNvCvMRmyEPc4eNRuo4U0
         WMA1oYMII0SjVMqFxf4CNAjUxcO9vvFrw+TCmOnTR/XaY2i/IOcOBtfjhJtOE8WurhVA
         w7FAoo2jm43gyI9Mx3tstwWCl6NWsQi5oicmfhvMJ5Xa8e+X4PmhqqI1R0ACj6EnyUab
         m844WNYr7ADdSF/MCOYoDYDxg8DcOa//bGMGrt/ACnV94vzgNLjRz/LSypgA0nso4myd
         XoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fubeP8Gpomxz1l4RpRKR7xeHEl2tknsqcnZNF0g+uDU=;
        b=TN3BLeCJ29FiSaqeAnt8B6RFwm3pnUj7uuz2OE5VO9QRAds1zbn5c71DwZeGdm8X0k
         sqdjmQAK/0u0ji/s95KTaiMcWX9cP0awf82ZzzTrTjerqV12UKkgUyw/cyve9sz+hFVE
         4Yn+sYixF7qu/wiNTz52udWKYVbs1ygyDQty7HnvbyrNt7zBJKbNHb9jUuwCRFsVn/u5
         n9k9bzU3/anOLLO1ZB9n1RHkgFXgVTocsLYbAUB6XFy5jh/e3kQp3cdoGuTMcgjKTZ+E
         0hON28h3iwYyaZmvsguMEqg87vEt0dxU7mgsAy1/g4CXenkS3xPqELh/AEVPO7NHnEBv
         /nZQ==
X-Gm-Message-State: AJIora8y8N+JkvKGlpvTJ57xxKClUSbXTW9xOQa5Vy42KKkErgpeCDy+
	TQFyLT3DDL/Ye+jTCaRwAmI03MfNhcE=
X-Google-Smtp-Source: AGRyM1u/PNI/pairR0e+NdkgQX39jvw+2i/mpW4YmyyT9uJPD0e51pWNZG7B4HqpCji3tI4XJYDY/A==
X-Received: by 2002:a63:2b84:0:b0:412:5277:99dc with SMTP id r126-20020a632b84000000b00412527799dcmr14025642pgr.208.1657146087294;
        Wed, 06 Jul 2022 15:21:27 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b0016a163d1cd5sm26517696plg.253.2022.07.06.15.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:21:26 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 01/14] client: add generic display function for table rows
Date: Wed,  6 Jul 2022 15:18:54 -0700
Message-Id: <20220706221907.126408-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was no easy to use API for printing the contents of a table, and
was left up to the caller to handle manually. This adds display_table_row
which makes displaying tables much easier, including automatic support
for line truncation and continuation on the next line.

Lines which are too long will be truncated and displayed on the next
line while also taking into account any colored output. This works with any
number of columns.

This removes the need for the module to play games with encoding newlines
and tabs to make the output look nice.

As a start, this functionality was added to the command display.
---
 client/display.c | 174 ++++++++++++++++++++++++++++++++++++++++++++++-
 client/display.h |   1 +
 2 files changed, 172 insertions(+), 3 deletions(-)

diff --git a/client/display.c b/client/display.c
index 07cb7bda..7ca3a767 100644
--- a/client/display.c
+++ b/client/display.c
@@ -376,8 +376,176 @@ void display_table_footer(void)
 	display_refresh_check_applicability();
 }
 
-void display_command_line(const char *command_family,
-						const struct command *cmd)
+#define COLOR_END(_str) \
+({ \
+	char *_s = (_str); \
+	while (*_s != 'm' && *_s != '\0') \
+		_s++; \
+	_s - (_str) + 1; \
+})
+
+/*
+ * Finds last space in 's' before 'max' characters, terminates at that index,
+ * and returns a new string to be printed on the next line.
+ *
+ * 'max' should be set to the column width, but is also an out parameter since
+ * this width can be updated if colored escapes are detected.
+ *
+ * Any colored escapes found are set to 'color_out' so they can be re-enabled
+ * on the next line.
+ */
+static char* next_line(char *s, unsigned int *max, char **color_out)
+{
+	unsigned int i;
+	int last_space = -1;
+	int last_color = -1;
+
+	/* Find the last space before 'max', as well as any color */
+	for (i = 0; i <= *max && s[i] != '\0'; i++) {
+		if (s[i] == ' ')
+			last_space = i;
+		else if (s[i] == 0x1b) {
+			/* color escape won't count for column width */
+			*max += COLOR_END(s + i);
+			last_color = i;
+		}
+	}
+
+	/* Reached the end of the string within the column bounds */
+	if (i <= *max)
+		return NULL;
+
+	/* Not anywhere nice to split the line */
+	if (last_space == -1)
+		last_space = *max - 1;
+
+	/*
+	 * Only set the color if it occurred prior to the last space. If after,
+	 * it will get picked up on the next line.
+	 */
+	if (last_color != -1 && last_space >= last_color)
+		*color_out = l_strndup(s + last_color,
+					COLOR_END(s + last_color));
+	else
+		*color_out = NULL;
+
+	s[last_space] = '\0';
+
+	return l_strdup(s + last_space + 1);
+}
+
+struct table_entry {
+	unsigned int width;
+	char *next;
+	char *color;
+};
+
+/*
+ * Appends the next line from 'e' to 'line_buf'. 'done' is only set false when
+ * there are more lines needed for the current entry.
+ */
+static int entry_append(struct table_entry *e, char *line_buf, bool *done)
+{
+	char *value = e->next;
+	unsigned int ret = 0;
+	unsigned int width = e->width;
+
+	/* Empty line */
+	if (!value)
+		return sprintf(line_buf, "%-*s  ", e->width, "");
+
+	/* Color from previous line */
+	if (e->color) {
+		ret = sprintf(line_buf, "%s", e->color);
+		l_free(e->color);
+		e->color = NULL;
+	}
+
+	/* Advance entry to next line, and terminate current */
+	e->next = next_line(value, &width, &e->color);
+
+	if (e->next)
+		*done = false;
+
+	/* Append current line */
+	ret += sprintf(line_buf + ret, "%-*s  ", width, value);
+
+	l_free(value);
+
+	/* Un-color output for next column */
+	if (e->color)
+		ret += sprintf(line_buf + ret, "%s", COLOR_OFF);
+
+	return ret;
+}
+
+/*
+ * Expects an initial margin, number of columns in table, then row data:
+ *
+ * <row width>, <row data>, ...
+ *
+ * The data string can be of any length, and will be split into new lines of
+ * length <row width>.
+ */
+void display_table_row(const char *margin, unsigned int ncolumns, ...)
+{
+	char buf[512];
+	char *str = buf;
+	unsigned int i;
+	struct table_entry entries[ncolumns];
+	va_list va;
+	bool done = true;
+
+	memset(&entries[0], 0, sizeof(entries));
+
+	va_start(va, ncolumns);
+
+	str += sprintf(str, "%s", margin);
+
+	for (i = 0; i < ncolumns; i++) {
+		struct table_entry *e = &entries[i];
+
+		e->width = va_arg(va, unsigned int);
+		e->next = l_strdup(va_arg(va, char*));
+
+		str += entry_append(e, str, &done);
+	}
+
+	va_end(va);
+
+	display("%s\n", buf);
+	str = buf;
+
+	/*
+	 * The first column should now be indented, which effects the entry
+	 * width. Subtract this indentation only from the first column.
+	 */
+	entries[0].width -= strlen(margin) * 2;
+
+	while (!done) {
+		done = true;
+
+		for (i = 0; i < ncolumns; i++) {
+			struct table_entry *e = &entries[i];
+
+			if (i == 0)
+				str += sprintf(str, "%s%s%s", margin,
+						margin, margin);
+
+			str += entry_append(e, str, &done);
+		}
+
+		display("%s\n", buf);
+		str = buf;
+	}
+
+	for (i = 0; i < ncolumns; i++) {
+		if (entries[i].color)
+			l_free(entries[i].color);
+	}
+}
+
+void display_command_line(const char *command_family, const struct command *cmd)
 {
 	char *cmd_line = l_strdup_printf("%s%s%s%s%s%s%s",
 				command_family ? : "",
@@ -388,7 +556,7 @@ void display_command_line(const char *command_family,
 				cmd->arg ? " " : "",
 				cmd->arg ? : "");
 
-	display(MARGIN "%-*s%s\n", 50, cmd_line, cmd->desc ? : "");
+	display_table_row(MARGIN, 2, 50, cmd_line, 30, cmd->desc);
 
 	l_free(cmd_line);
 }
diff --git a/client/display.h b/client/display.h
index 7747c6a0..c34cab9c 100644
--- a/client/display.h
+++ b/client/display.h
@@ -37,6 +37,7 @@ void display(const char *format, ...)
 		__attribute__((format(printf, 1, 2)));
 void display_table_header(const char *caption, const char *fmt, ...)
 		__attribute__((format(printf, 2, 3)));
+void display_table_row(const char *margin, unsigned int ncolumns, ...);
 void display_table_footer(void);
 void display_error(const char *error);
 void display_command_line(const char *command_family,
-- 
2.34.1

