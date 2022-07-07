Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4918D2563
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 17:57:22 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id y141so20895989pfb.7
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOM5jVCYT8HDLJC9OsOQuzgGtVxd7IKhBqopko8l0ds=;
        b=eY7w/jK77vi8B/oMTEVVMY+JRIdLSlBAoiyMLebpDCEdTl3sJzpiHV6kJuS7pYkQef
         r9hEBfA64SEsUfpgX7ClPdcweoq/P1yWlVQ709a5n1rO5fKQz7GIwi81zXxN1NyVLvuh
         Ba7yx0BTHrwMqvvf4eThQcnIy6U0be1+It+WUqDy3jYJYh1WDQJWyen3s8XhJrkbsME2
         G0ARw1J16x1CI4vU7Kf6D6GQDU61+B+YfDmvoYTzs7gRDysFy9TbeIIfmwiomdTZNcZg
         WBpUjIhwbDm8lUm2OJ4lYBsXOfxUPatuTAe4Ux2KFrspOFYs04JGS0cZ1zFmjpiBVpcT
         fGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOM5jVCYT8HDLJC9OsOQuzgGtVxd7IKhBqopko8l0ds=;
        b=DSzjg+hJ1lpJQuPcdmIuJjYoFD9hR5XlPdV00O6SEFVWE0AqRqrYPCzQQsYsUiF/vb
         FYd94TuX2jcQJOcA2VgHP2nfo6Ydiz40dMbaKJtfi2955J4ck3RJ/qjXzRjRwOH09ie6
         HEiRkwH6LBbxv9OymUXdjdYCdd0k0L8OYIHTlOonKtO2NtgG3mIOnj0JQDpHUQrAt11M
         emdqSSrPPGUXkmQueX5qmJ5oOEve9+msFyi8u561FCfhD61q2277EQEGbgp2qvYFQA9t
         /drzPALWB423y34yJXJgvpUtNOZhYcK4ZtmGT4miqoamzjqGjKhse13Foscrji7cHnsA
         qrPQ==
X-Gm-Message-State: AJIora/aa5/Epn3ooJxeJCTsH2FTvXkHIsfBvBNP/4xAXSFzJWe/S+SK
	hHTR+xgS6BMMdE0SFeL7esbqltivgs0=
X-Google-Smtp-Source: AGRyM1tFVognMDGCCBL/Diw+7YPR4NiPEOuo3+slUJK7lSxVNVzDbvP4FT/inLTWHaZW8eTfIbacFA==
X-Received: by 2002:a17:902:f785:b0:16a:4f3b:a20c with SMTP id q5-20020a170902f78500b0016a4f3ba20cmr55266583pln.118.1657216641365;
        Thu, 07 Jul 2022 10:57:21 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001618b70dcc9sm28855223plg.101.2022.07.07.10.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:57:20 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 01/14] client: add generic display function for table rows
Date: Thu,  7 Jul 2022 10:54:58 -0700
Message-Id: <20220707175511.224597-1-prestwoj@gmail.com>
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
 client/display.c | 181 ++++++++++++++++++++++++++++++++++++++++++++++-
 client/display.h |   1 +
 2 files changed, 179 insertions(+), 3 deletions(-)

diff --git a/client/display.c b/client/display.c
index 07cb7bda..8ebbb656 100644
--- a/client/display.c
+++ b/client/display.c
@@ -376,8 +376,183 @@ void display_table_footer(void)
 	display_refresh_check_applicability();
 }
 
-void display_command_line(const char *command_family,
-						const struct command *cmd)
+static unsigned int color_end(char *s)
+{
+	char *start = s;
+
+	while (*s != 'm' && *s != '\0')
+		s++;
+
+	return s - start + 1;
+}
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
+			*max += color_end(s + i);
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
+					color_end(s + last_color));
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
+static int entry_append(struct table_entry *e, char *line_buf)
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
+static bool entires_done(unsigned int num, struct table_entry *e)
+{
+	unsigned int i;
+
+	for (i = 0; i < num; i++)
+		if (e[i].next)
+			return false;
+
+	return true;
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
+		str += entry_append(e, str);
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
+	while (!entires_done(ncolumns, &entries[0])) {
+		for (i = 0; i < ncolumns; i++) {
+			struct table_entry *e = &entries[i];
+
+			if (i == 0)
+				str += sprintf(str, "%s%s%s", margin,
+						margin, margin);
+
+			str += entry_append(e, str);
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
@@ -388,7 +563,7 @@ void display_command_line(const char *command_family,
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

