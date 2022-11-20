Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2AF20E0
	for <iwd@lists.linux.dev>; Sun, 20 Nov 2022 16:10:28 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id 136so9154019pga.1
        for <iwd@lists.linux.dev>; Sun, 20 Nov 2022 08:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyrqbBFaYb8n2tx4TAOXPliAejbPtFUIErzvsl4Zgy0=;
        b=F6DvoWzrNxB6CoYpVKca1NblzPWwFb5IMUPueGiz8nDVUoA4UKUhNw1gOPlia7sAPN
         M5AQFoWwbazAlsswT2Jc+bnCgRQlSDcvJdVIBBqwBznINlBhlvFxTLbUXJA/d80vP7pt
         FrV0zTsBw2zIjNMVN/jLmiSPygE353gBmcyBZlGVsMBFZ2GOW7Wa4U0zEEDFyVsFiOqe
         gAyj9w5Mc/HcDjnAYZFlvlODLRsHFt1oz7XA9/RPPKho15pRProOLPMQLnIwzbPxSkHY
         4LkeNwoghf5HgF9wMlnt3Uo+8myUCcsEL77g8fzEHnHcy5OikYsCeYg/cZxwa09N8LVV
         /Bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyrqbBFaYb8n2tx4TAOXPliAejbPtFUIErzvsl4Zgy0=;
        b=Y8LmGvgMTNYmXfTEj8bO4+ut8m/tlS7o/ec55Cz8KtQVCPv5SimfWF2AEcWGzMjX27
         NWq7Th9jR4ganEttRBh+0bPOPg5Dmpxt+hpeZGocnm636VFYhvYVEv2699VPtfi/uS6p
         rYZuaj6jbWxqQyDNOTmeKWGWuFtgVz5W2+H4eyM271Id/+bnG39KAx5O6vTkd+8h1WOa
         6qIV9W6xv6AFPN/H2u1nA9mlPIxRR5rys5+kA1+vE5wE4LX9u89GrzUe6aA5CSuItzbT
         x5PuVH3wUitun6ICVC/GD/tek/ijkyjbXvX66qXJ0ZXrOriVGzmmwXZYzJYzwTgy9X2K
         cbuA==
X-Gm-Message-State: ANoB5pnXgwcc6/oY7028PGF25+RXdzJ9iiyhVeMypGiJO05+ZlRHoMWu
	QyRd0eHA0W6yx5zlLYdD5MN8S1QXaHJOtw==
X-Google-Smtp-Source: AA0mqf4grhAXKPOMeFzYSSQ4JrsjCAMXPlmPAu87JI2bepCOkm0Bkpffn3A4AnN91fLNl18WyV/NGQ==
X-Received: by 2002:a63:5b54:0:b0:476:c490:67e2 with SMTP id l20-20020a635b54000000b00476c49067e2mr1433013pgm.552.1668960628110;
        Sun, 20 Nov 2022 08:10:28 -0800 (PST)
Received: from localhost ([2a09:bac1:3680:80::1c5:81])
        by smtp.gmail.com with UTF8SMTPSA id p4-20020a170902e74400b0018691ce1696sm7728380plf.131.2022.11.20.08.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 08:10:27 -0800 (PST)
From: Neehar Vijay <env252525@gmail.com>
To: iwd@lists.linux.dev
Cc: Neehar Vijay <env252525@gmail.com>
Subject: [PATCH 2/3] gitignore: add .ccls-cache
Date: Sun, 20 Nov 2022 21:39:15 +0530
Message-Id: <20221120160912.72307-2-env252525@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221120160912.72307-1-env252525@gmail.com>
References: <20221120160912.72307-1-env252525@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This directory is used by ccls.
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index f215701d..bc429883 100644
--- a/.gitignore
+++ b/.gitignore
@@ -5,6 +5,7 @@
 .deps
 .dirstamp
 .cache
+.ccls-cache
 compile_commands.json
 tags
 cscope.*
-- 
2.38.1

