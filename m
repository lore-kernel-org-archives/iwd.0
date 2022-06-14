Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B872F21
	for <iwd@lists.linux.dev>; Tue, 14 Jun 2022 23:37:37 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id i15so9020670plr.1
        for <iwd@lists.linux.dev>; Tue, 14 Jun 2022 16:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fSmuJEN3gBAmZLdQEAae5VrrSum5TbqQyeWYORbZFI4=;
        b=E6GqZ6/LNSOiliO3QFIEDh04yk8xVucpXc80sManTH90tb5rMi9OGNQyN/pO+PdtZX
         SKoeRzIFSzNi0sc0F1SJS9IzZlfG5x1EAjnDDeXCd3uh/HvCbE44lnCZlaB92czbtle7
         Gjmr/8JCW7E2jdpQWsIQj4C4CcEHgudkp1Iaw/GVzZoHoga8PE7ebtpGJr/NkD+hz+vz
         NDSdFMW8/rt1D8UCEkMV42lqA+OnT3mJo4LrV1xNMwj2IsVGLW/wgDr7//MasAJmpNJi
         QmbNenDGvYfYr341qYk5T/c0FbiQbSciSkhSl4enwaeGL6SFVscXChkF1XIslaP33GwK
         OgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fSmuJEN3gBAmZLdQEAae5VrrSum5TbqQyeWYORbZFI4=;
        b=g81gW0Q6YhuYUrXRtx9FHZO74035qJ3SHa4Z5K7m3vRiaHAWqEWDrzGnFDohFy6RfO
         6b5zGxC0bgKEW1sESWFa3G6n+P5g8UO/oD4PL2ENy9/i7i+99sLTw0y7+eX6LuncOAKp
         lCUgUIV/TXzpdviBsdTg7C7imsqaqtAZURA+Jn5G1oW35dMtAbZ6Rll36ASH0BjR5wiB
         AlX60TnRb9LIj/hQi2r4RVasfEGBZcgLcTv6rTMv8zfziR6nEMmoFZSeVcu/3a6a5gS7
         xpRFrhMMKPlYNe5bLIgGg+JJLEEH3UqgV0seOL8BR7OGSKIXFyb+5uS9RF4oNwQWlJFD
         71fQ==
X-Gm-Message-State: AJIora8aCS+LKho55bmf0Ijn8OX5FvXYpBTp702zphG1vS4/+7nsCueN
	pYGtdfJn5vF2KgyOs5EGy+GCEgKs2AI=
X-Google-Smtp-Source: AGRyM1s8/OnuDewDdzA1yIvq9SB0jwbZ7xA8OqT7ekI3bxX4Xx9JBFPZGQ6PR9q3EsggL9yW2ZJNAw==
X-Received: by 2002:a17:902:7005:b0:163:ffe7:32eb with SMTP id y5-20020a170902700500b00163ffe732ebmr6612109plk.18.1655249857281;
        Tue, 14 Jun 2022 16:37:37 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id x15-20020a63b34f000000b003fe28130b12sm8248614pgt.62.2022.06.14.16.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 16:37:36 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] storage: warn user on badly named provisioning file
Date: Tue, 14 Jun 2022 16:35:29 -0700
Message-Id: <20220614233529.714721-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The man pages (iwd.network) have a section about how to name provisioning
files containing non-alphanumeric characters but not everyone reads the
entire man page.

Warning them that the provisioning file was not read and pointing to
'man iwd.network' should lead someone in the right direction.
---
 src/storage.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/storage.c b/src/storage.c
index 2100d08d..528bdbf4 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -321,8 +321,12 @@ const char *storage_network_ssid_from_path(const char *path,
 			if (!isalnum(*c) && !strchr("-_ ", *c))
 				break;
 
-		if (c < end)
+		if (c < end) {
+			l_warn("Provisioning file %s contains non-alphanumeric "
+				"characters in the name. Please hex-encode. "
+				"See man iwd.network", path);
 			return NULL;
+		}
 
 		memcpy(buf, filename, end - filename);
 		buf[end - filename] = '\0';
-- 
2.34.1

