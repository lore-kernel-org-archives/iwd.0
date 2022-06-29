Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D267A
	for <iwd@lists.linux.dev>; Wed, 29 Jun 2022 19:29:17 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id cv13so16568036pjb.4
        for <iwd@lists.linux.dev>; Wed, 29 Jun 2022 12:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hGNIyz1SSJAjs9vNjEYg+XJJhw8sk8UkWWsSzCbZNt8=;
        b=MExaCisBmQjiSzqiKpoLcyhmO7fYeqk8f8hYHjP4PmMML2dNFrLXYKbC75kxgQgUwm
         iimo6qWVmgClhuXoVEEsNZ3FSOVtIfHhpuwZ1DSChggxezBg1uOikZY12pNCE/io1J91
         Hs45MpDRnltmdfF+P7zAdFBYYzIIfxldjDKTpD6Ut3LIlcPd2ivDg+C6ZGcB3BFnLm3t
         Dx9aOmhNav2BfGAQ+E9cge9+MH7K80xi3Dy3I8VQBvTqjpoW2zBhdRya7kGVtg0V4DCE
         GMWipSWDwst47f4urmhGMXfT+2pa7XQYbRK1Rn2AqO5dD64vh2lRFQ/eP9JQbZKwGLwf
         yGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hGNIyz1SSJAjs9vNjEYg+XJJhw8sk8UkWWsSzCbZNt8=;
        b=HN9LqF+CnCnICH+0aEQCPTNBPylEw4a0bevrrKCT/0eMruAMKfmag3XA7i/E8WWqr7
         8tU7a6IxIGWUPZDhzEhsVg0S4j9hZwJsifGmHWYsheZSICoGaedp/v7M/x/xNKgjSY1n
         CGJO3pgWPk9+MJMVCBGi7Cdg2UVu5kqI4QRv4jk90nDXuGeVziBNtlApWI99kg91Rfav
         iwUCcsgqTuBspSSyTXw3jy25ANPxM91VJoWvbaLJpjSMuoFsk84CDJ0gUJmTwEehUdDs
         yOp98vh3yXpyP2Lx2Xd4Ju63vTr7yAKbn2UENdePPPXV+MbvFA6E7ZO9N8N87SUzsC+H
         w0ng==
X-Gm-Message-State: AJIora+nYI/nthrigJpJPzMFjTJ6tF7PewPoqtb4TNph7W4pYDLud3xr
	dzQ5Y6lp/93lbt5LRsm4GGb3WmV0x/s=
X-Google-Smtp-Source: AGRyM1tKFKI8wnk0DAxXud/IjBVSVWh/TWcC85ubGV2Mooug54EXgvYzV6DXqo8llWkV830P0KMObQ==
X-Received: by 2002:a17:90b:3e89:b0:1ee:195e:abaf with SMTP id rj9-20020a17090b3e8900b001ee195eabafmr7665325pjb.112.1656530957131;
        Wed, 29 Jun 2022 12:29:17 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id i29-20020a63585d000000b00407e25d4527sm11497734pgm.22.2022.06.29.12.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 12:29:16 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] client: support multi-line print for long values
Date: Wed, 29 Jun 2022 12:27:08 -0700
Message-Id: <20220629192709.38743-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic proxy property display was limited to a width for names/value
which makes the output look nice and uniform, but will cut off any values
which are longer than this limit.

This patch adds some logic to detect this, and continue displaying the
value on the next line.

The width arguments were also updated to be unsigned, which allows checking
the length without a cast.
---
 client/dbus-proxy.c | 21 +++++++++++++++++++--
 client/dbus-proxy.h |  3 ++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index 624ce4aa..9f05c0e7 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -49,7 +49,8 @@ static struct l_queue *proxy_interface_types;
 
 void proxy_properties_display(const struct proxy_interface *proxy,
 				const char *caption, const char *margin,
-				int name_column_width, int value_column_width)
+				unsigned int name_column_width,
+				unsigned int value_column_width)
 {
 	const void *data;
 	const struct proxy_interface_property *properties;
@@ -67,14 +68,30 @@ void proxy_properties_display(const struct proxy_interface *proxy,
 	properties = proxy->type->properties;
 
 	for (i = 0; properties[i].name; i++) {
+		const char *str;
+		size_t len;
+		size_t j;
+
 		if (!properties[i].tostr)
 			continue;
 
+		str = properties[i].tostr(data);
+		len = str ? strlen(str) : 0;
+
 		display("%s%*s  %-*s%-.*s\n", margin,
 			8, properties[i].is_read_write ?
 				COLOR_BOLDGRAY "       *" COLOR_OFF : "",
 			name_column_width, properties[i].name,
-			value_column_width, properties[i].tostr(data) ? : "");
+			value_column_width, str ? : "");
+
+		if (len <= value_column_width)
+			continue;
+
+		/* Display remaining data */
+		for (j = value_column_width; j < len; j += value_column_width)
+			display("%s%*s  %-*s%-.*s\n", margin, 8, "",
+				name_column_width, "", value_column_width,
+				str + j);
 	}
 }
 
diff --git a/client/dbus-proxy.h b/client/dbus-proxy.h
index 1d6af5de..34917e82 100644
--- a/client/dbus-proxy.h
+++ b/client/dbus-proxy.h
@@ -89,7 +89,8 @@ bool proxy_interface_method_call(const struct proxy_interface *proxy,
 
 void proxy_properties_display(const struct proxy_interface *proxy,
 				const char *caption, const char *margin,
-				int name_column_width, int value_column_width);
+				unsigned int name_column_width,
+				unsigned int value_column_width);
 
 char *proxy_property_str_completion(const struct proxy_interface_type *type,
 					proxy_property_match_func_t function,
-- 
2.34.1

