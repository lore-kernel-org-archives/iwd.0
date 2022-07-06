Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8269253B4
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 21:30:59 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id a15so9619003pjs.0
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 14:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fubeP8Gpomxz1l4RpRKR7xeHEl2tknsqcnZNF0g+uDU=;
        b=c4dSAKn5jp/k9CsN9AS7R6eFx355vzvohbwXypJnW9nVn8nkw/XE//Wk4x3HTHoCEC
         6ERfzTCUxmrbbD3SZfs1diEDgb40iYV6LGH1TPgxRU5ULYmtDiLDWeRdiZDgAW3YP6nl
         I01M79hkouMKSCjK/JrzKuyDrj9X2Bi4YWBx4U31zSqMyKXWCp0oPkBTjPzBNTTbjAH7
         TMryKWqiYyRqmnV+Fhrghzx6+Qh8zG7AvptKlcbIThaOo8deHS2jn70z6oVGZ8mhdUmT
         icW2bRUAwl1OHFeTGsQuWXRwoIbwbDWNLKf7C1u6nISAeSTUh712YAViWpzMge+Nh/SU
         vu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fubeP8Gpomxz1l4RpRKR7xeHEl2tknsqcnZNF0g+uDU=;
        b=XmLDdiWWhFlHjJHnQ3Rt6wkPcaUzFLwKb4j3hU91gonKOfcRoKNMjBC9enpkfL7mtJ
         anfhVKW3z562J1XKUNNQHB4DLN/NSdp4feax6pXFQo6TFiY/NDPVvmGBPhRM2K1mST7T
         ZNZOiX7Vf1wWeiytVkTN4Ks6/7EJVBQK6ijHu9PVGjH1hj2UkgzEUe1twKKvWBv0C6ED
         Fs3pc0GqTpO8+46j7u3Sh/Usj7Oc+b6z7k8K55NXlyc/NKZfRN8o1HsA42XAWuxMdVOg
         Q7J8u/27/ECizPFbZqKtuMPSZPxVO1P+9z5YguZFOJ3NGzZNnnR5FG96gvbEXR/z9KPN
         I+xg==
X-Gm-Message-State: AJIora/zcrnq9I982BMXxAVa7qVd54ua0QHSCpaLAeLblovlfGRIHEH3
	Yz3e+ozx4t7zmKx4YMepDWKMfq3qZgQ=
X-Google-Smtp-Source: AGRyM1th8Gqafdmk6TIG8dzI0UnTR8erReC/HCwRMafrkjNO3Pyx9GChFPuhXjYt0Bsx/uUnM1YIiw==
X-Received: by 2002:a17:902:bc45:b0:16b:d5bf:c465 with SMTP id t5-20020a170902bc4500b0016bd5bfc465mr25774765plz.128.1657143058498;
        Wed, 06 Jul 2022 14:30:58 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id v6-20020aa799c6000000b00527f5aee1a4sm15347609pfi.33.2022.07.06.14.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:30:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/14] client: add generic display function for table rows
Date: Wed,  6 Jul 2022 14:28:38 -0700
Message-Id: <20220706212851.92685-1-prestwoj@gmail.com>
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

