Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF023D99
	for <iwd@lists.linux.dev>; Mon,  6 Jun 2022 21:34:37 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id 123so3638267pgb.5
        for <iwd@lists.linux.dev>; Mon, 06 Jun 2022 14:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2HZxrZTIZO0h8plCyaiLWQzj23TZkWTFzXXgFfpB0cc=;
        b=oIh+RXQIKLmOymNPwswPWfNkgHrH5qPvFUOxWZxlmapA9tJBgfcRTq0mVCWdfwFBED
         C8HoBznar/g4OISwtraASu+dpfKrncze7c2l5YZGfY3+O6RWERWYpLhMtFV5xuEJKzTV
         ahUdLWDOCNH/uq1+ItUtJYd38IflW39Fc8T1s9JnPLgxYk0u+jR8v3e2Z4fDoQPSwtf4
         FdJQuflXcdc/pMRVW8VcsTnU5TMtFxDAOD81VvmqDqnd4GTUmJh+MfqMDj3UfHwMn44m
         ktvjK5SpRyV4O10HuYbTXHExhX2udjFrVW9QY9MFQBnfnt1rs1kmyb3mJgveF8WQyPj2
         S4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2HZxrZTIZO0h8plCyaiLWQzj23TZkWTFzXXgFfpB0cc=;
        b=tuz5//qV+gjFUSmi7aEG/ZodGxgreRLtp97yd0VfDfckUQtIxHD6DFNrjRUQbFni2f
         INuqMgMQEWHbUkMC2VVUR4LIPr79zguRGVa+3by1l+fFMPI6jrMMhtKz+M6ruWDZRrqC
         6EzvnLmxnHLE8Wu1uJUrUuyIhBxBPE3Pkq4PPs2E4mUoY5pxUDXgCe6A3btOBDQfDAEy
         n2y/FYqbknxBmJVYBFHcrDrZbwAxdz2dj3VMStPkyIGqOzSCtLj5bDFulWmHDit2XWwK
         CVNzgQ4st5fjsKPzZFAbybdXJG6wOn8xIEBoOy2eQg/qmD1VbdzmWChnbaEsIey0V9ay
         nveg==
X-Gm-Message-State: AOAM533MfVY/iDzgwVFsyCbDaaEwZenKAip+5gqhxglpuf2c73xjoFEF
	EtXD7X74L4PwL5Pig1vYVYU1bUtJDGY=
X-Google-Smtp-Source: ABdhPJyQoatr0Uy+zmPvGmzbl+LYd97DD02p+nCFE1iLEoBkl6XnmH3kAx+ObJZuasW/dK1X7oto4w==
X-Received: by 2002:a63:d507:0:b0:3fb:22d1:8a51 with SMTP id c7-20020a63d507000000b003fb22d18a51mr22034962pgg.377.1654551277142;
        Mon, 06 Jun 2022 14:34:37 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902f39500b0015e8d4eb1d7sm10872065ple.33.2022.06.06.14.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:34:36 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] station: this should break
Date: Mon,  6 Jun 2022 14:32:15 -0700
Message-Id: <20220606213216.36873-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220606213216.36873-1-prestwoj@gmail.com>
References: <20220606213216.36873-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/station.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 0fbc76f7..f9978c4a 100644
--- a/src/station.c
+++ b/src/station.c
@@ -123,7 +123,8 @@ struct station {
 	bool autoconnect_can_start : 1;
 };
 
-struct anqp_entry {
+// break the build
+truct anqp_entry {
 	struct station *station;
 	struct network *network;
 	uint32_t pending;
-- 
2.34.1

