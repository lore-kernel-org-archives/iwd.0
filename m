Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF51101C5
	for <iwd@lists.linux.dev>; Tue,  2 Jan 2024 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2WAJWid"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-427e59202ceso43298161cf.0
        for <iwd@lists.linux.dev>; Tue, 02 Jan 2024 05:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704200639; x=1704805439; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bjMXCWKqQE2iypsGAtc+P1jgQPaMOzrZ60scronOu1c=;
        b=j2WAJWidoe2gHvePcenfsUgD5wggm4Q/vg5wqMLA2zjhfU5Jir2CkgK/vpTwc5h4JG
         qgH+6oVspgbtQFIqWNEDSBwGuQ9orKJc+ydytbVqeMu0GP9HSzSB5Q2DqwKg/gGczMIj
         VHALZV6dJbSJdM9e369R+duGbPA+vfAjH0udDZC4y9x9GSTfZtQz5S7FNpwGfQvJBYOW
         y+0TMzi+qwHdg5E/JXOjBhJP+f+6gV6rFWjD4enWL9BZIMRp9KdT4qYOR5/RYZaJodfn
         Jy2Qv5wdjuUfV7aKE8HMnWuS7xyByfudyPaY+loaqB5UP7Q9JZCNzPM76fzRrs9rXnT0
         VLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704200639; x=1704805439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjMXCWKqQE2iypsGAtc+P1jgQPaMOzrZ60scronOu1c=;
        b=R5pxAjo40K65nJuEYxwnDPtwJ0IgMXfVuTU/BTn3P0+Y2FMvgenWK8mnaBeHHpWEIm
         yTtNkBGeDBzpKVktBqbm2bOkbqZ0RnDvPTPGvOeXQYDIHwniSqaaK7yKorIzDISXbKsv
         Pqqq8iAhyoORxMhylfPwch0immvi+ctSD7xpsJRQKHe15ifYFZCL29UIHZf3YOvfjcBM
         9ziuhnr0JRnJiBTbDYBGoLvn3GwmZvdDyQgtZ5puvzOSoR8NgTVRDphcKsOTn9wGeGwP
         5h3UUyAzkG4Mw2r12M7wrpqiWjTyDaBcuW+j5TDiObCVzfaV5fV+5ywhoNN7ZSFvJf2w
         j0IQ==
X-Gm-Message-State: AOJu0YxTn4FMjejlzhnlEdebpXFjC0H3es7esidX/P1iU9LAB+1t5jG/
	MgK92nkbbai6VX6QFpoeErvzG0jrgPQ=
X-Google-Smtp-Source: AGHT+IGR5nZRJjO90XlTKt0Dr2I4TpWkCzcqlojIgCIeoTAhAaViAsBmkDw4O0w7nB4z2luu4PquIQ==
X-Received: by 2002:a05:6214:d66:b0:67f:fe7:c30e with SMTP id 6-20020a0562140d6600b0067f0fe7c30emr29084804qvs.117.1704200638786;
        Tue, 02 Jan 2024 05:03:58 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id e8-20020ad442a8000000b00680c49f8650sm383517qvr.112.2024.01.02.05.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 05:03:58 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] monitor: indicate if the MPDU was invalid
Date: Tue,  2 Jan 2024 05:03:55 -0800
Message-Id: <20240102130355.17660-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the frame was not parsed as an MPDU indicate this in iwmon. This
also adds handling to print probe requests.
---
 monitor/nlmon.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index ed40264b..6845ca53 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -5128,6 +5128,16 @@ static void print_probe_response(unsigned int level,
 			(const uint8_t *) mmpdu + len - resp->ies);
 }
 
+static void print_probe_request(unsigned int level,
+				const struct mmpdu_header *mmpdu, size_t len)
+{
+	const struct mmpdu_probe_request *req = mmpdu_body(mmpdu);
+
+	print_attr(level, "Subtype: Probe Request");
+	print_ie(level + 1, "Probe Request IEs", req->ies,
+			(const uint8_t *) mmpdu + len - req->ies);
+}
+
 static void print_beacon(unsigned int level,
 				const struct mmpdu_header *mmpdu, size_t len)
 {
@@ -5165,7 +5175,10 @@ static void print_frame_type(unsigned int level, const char *label,
 
 	switch (subtype) {
 	case 0x00:
-		str = "Association request";
+		if (mpdu)
+			str = "Association request";
+		else
+			str = "Association request (invalid MPDU)";
 		break;
 	case 0x01:
 		if (mpdu)
@@ -5174,19 +5187,28 @@ static void print_frame_type(unsigned int level, const char *label,
 			str = "Association response";
 		break;
 	case 0x02:
-		str = "Reassociation request";
+		if (mpdu)
+			str = "Reassociation request";
+		else
+			str = "Reassociation request (invalid MPDU)";
 		break;
 	case 0x03:
-		str = "Reassociation response";
+		if (mpdu)
+			str = "Reassociation response";
+		else
+			str = "Reassociation response (invalid MPDU)";
 		break;
 	case 0x04:
-		str = "Probe request";
+		if (mpdu)
+			print_probe_request(level + 1, mpdu, size);
+		else
+			str = "Probe request (invalid MPDU)";
 		break;
 	case 0x05:
 		if (mpdu)
 			print_probe_response(level + 1, mpdu, size);
 		else
-			str = "Probe response";
+			str = "Probe response (invalid MPDU)";
 		break;
 	case 0x06:
 		str = "Timing Advertisement";
@@ -5195,25 +5217,28 @@ static void print_frame_type(unsigned int level, const char *label,
 		if (mpdu)
 			print_beacon(level + 1, mpdu, size);
 		else
-			str = "Beacon";
+			str = "Beacon (invalid MPDU)";
 		break;
 	case 0x09:
 		str = "ATIM";
 		break;
 	case 0x0a:
-		str = "Disassociation";
+		if (mpdu)
+			str = "Disassociation";
+		else
+			str = "Disassociation (invalid MPDU)";
 		break;
 	case 0x0b:
 		if (mpdu)
 			print_authentication_mgmt_frame(level + 1, mpdu, size);
 		else
-			str = "Authentication";
+			str = "Authentication (invalid MPDU)";
 		break;
 	case 0x0c:
 		if (mpdu)
 			print_deauthentication_mgmt_frame(level + 1, mpdu);
 		else
-			str = "Deauthentication";
+			str = "Deauthentication (invalid MPDU)";
 		break;
 	case 0x0d:
 	case 0x0e:
-- 
2.34.1

