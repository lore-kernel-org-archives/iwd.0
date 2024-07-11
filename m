Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB13C42AB5
	for <iwd@lists.linux.dev>; Thu, 11 Jul 2024 22:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735750; cv=none; b=PNI2/IzxxQBdSbuswM5KmtYyY0g9sbSZnqOJY6mGfGNqJT995KBZTmp5YqkWps5MkyXFLahq565EVb9hof5s4z6RVw0E2XszjRCdqqQV2uZ4o1rfVOCSziciSItfBVEwQVDOUw3RA520Zo1vifdOpiacJtZxQFdA3M+xHFzsiOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735750; c=relaxed/simple;
	bh=LFEMYZBAHkrMq22X7mktEF/xiaYSgJzkwWw5SnI04qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T0a6mf2w74igso4XmUiuY7n9zdt06Dw5jANGW+XcljOBEJ29+QSfqWmJHB22lSHHtSg3rFccZzfN9fCXzVF33SbCdYYp4s9VJ+foKSki74Js2wrMnvlgt0D1wEW0EHEtzUOkbRnqQHBT5rFYv2eGH6/u3aT3IzmZ8NceRJpSHyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=QSKRiQTS; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="QSKRiQTS"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44930ea05b8so9518801cf.1
        for <iwd@lists.linux.dev>; Thu, 11 Jul 2024 15:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1720735747; x=1721340547; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z18pq+Vgr6uqSx1eJ3RrQius6tP4iiCG1qwc7U7agAY=;
        b=QSKRiQTS5RM3tIvhAE67oioqfauCzgLXHdFhDZxKp6Y/DDQmBZ0WyfETT8h7/cv9AQ
         qFNLdifVx5HdxBcVK4WzbJWb9g+4N14G23Q4w3j2mhCkl/RntnrbFNCgcN++jt76Wtoz
         nRf++ViG/NCNTOoALBdSOHCSrzaNGbze8P1ampWsusyaMuR6eHuUkBezgKFeFYzXgCIT
         Ji1EUJWUZGbhwEoDk2puSVRRLXFllCg5mNzvpN0vOIXFatEo9X6rse3l/3guuLjLPuh/
         UVkJPhZ1n2xofU9scFE/6aYDJapHnrkcEl53JtSmboml13WRCNo6nI9SsNha/gMTJIYn
         73xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720735747; x=1721340547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z18pq+Vgr6uqSx1eJ3RrQius6tP4iiCG1qwc7U7agAY=;
        b=LdtaEZ16ckicCutbBJB6pYI1jAP5Zhbz+aCPKV0RI6ZxhTdyFr0NdqyGMzIl5oLgRG
         oluSfZR6rHSSMptH5Cocfuu9fGH7CF3Yu4SKOk5o7qee4Qc3ifuX/HW8CLfOlLKjM0/U
         W6zNWRzmblPG7ZAWSCN28578VWYnMZMFrZ3sjxPoMDz5T8z1B+9+k+DPJWPG50bBn8Rx
         epdRqv2CWdM28ohZhT8RoepsmPhUcyo694psyMKgujTUCZeUuFQkpUr0AxMJ7v7KlaSw
         jwyYOOU4EQf4ICIRDk/LKAw83sTFG8k7bqiMYWlaO4y9CzOgREeSQckoK/GmEWcyByxM
         UsYg==
X-Gm-Message-State: AOJu0YyJU4hCKOaTxmJw5fgnV56VZcNkVGuerx52EnZOAn+JYObXRigd
	jTmbHDCWNgus6JgC1PkJI0FxY47iWTsBHOkV9RBwHGWuBbhhee7LKGisW4BEiG7rhkL5h9taX5L
	UR2/dWChtfePwsPiPCXwF0nSI+P5zGPBjv8jXY3ycZR6K0sX9wxbaBrpWZqZMeANWI7Q6t537ij
	xCsoPpFrnNpyVN81MelMV9RVV/7TKIdgD46FiOuUl+GoE=
X-Google-Smtp-Source: AGHT+IHV+2YDUp+IkEOWyc1OGtq6VHL/xURmmkLCWFMTQXq/NhNAh5kYZAhbplBudCDQTGcgi5Us8w==
X-Received: by 2002:a05:622a:52:b0:446:710c:fed0 with SMTP id d75a77b69052e-447fa89b992mr116295311cf.29.1720735747353;
        Thu, 11 Jul 2024 15:09:07 -0700 (PDT)
Received: from localhost.localdomain ([140.177.191.129])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44c2c6b9f31sm17062361cf.80.2024.07.11.15.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 15:09:07 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: iwd@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH] main: set the identity in the logger
Date: Thu, 11 Jul 2024 22:07:50 +0000
Message-ID: <20240711220753.17831-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This causes "iwd" to be output in each message sent to syslog to help
quickly identify iwd messages.
---
 src/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/main.c b/src/main.c
index acbfdc0c34b2..93d4e87c653a 100644
--- a/src/main.c
+++ b/src/main.c
@@ -531,6 +531,8 @@ int main(int argc, char *argv[])
 	else
 		l_log_set_stderr();
 
+	l_log_set_ident("iwd");
+
 	if (check_crypto() < 0)
 		return EXIT_FAILURE;
 
-- 
2.43.0

