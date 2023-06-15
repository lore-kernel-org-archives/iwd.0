Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86681EADD
	for <iwd@lists.linux.dev>; Thu, 15 Jun 2023 19:24:28 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f8d0d68530so24218285e9.0
        for <iwd@lists.linux.dev>; Thu, 15 Jun 2023 12:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686857066; x=1689449066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KprZVBr41QPG6SMt/nydVp5LwmeTRftvUPqw1XBlt/E=;
        b=mjiDNoQeE0K8/xVfJm0k0aL/OcorizeHlReIIrT1PC7ZuBUdwG2u4EcT0szyiwTV7m
         3xBqHcEVgqBd5iynfkLHy5xPMk2IpP/wxQYOZlRfqIMq7dtiiFE2uw3w/dYzdJBl22PW
         GAUPYwiFnz0E3bpAfuhMx51/1pcD4LPQIsWTY0RLJ0WvwDqmqvJjUakKbwXgvKHkahLy
         T3oaGYCb/MutMQLEBb2JZkZFwjfOFLcg6ML6MfFMxf92zb+FfNwfNZJTkFQK/YQNP3d0
         c9FA5GlTF0VWqxUvpWbJFrG+MYyvYZFicEMcqvRgaUIoyR8520tl3FJfIgtK2048KMLj
         VOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686857066; x=1689449066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KprZVBr41QPG6SMt/nydVp5LwmeTRftvUPqw1XBlt/E=;
        b=bqT6kJ5vzk047aWcMp8h//JfPzB++8SEaxRo9eSQ/tI8YaXrhVr6ZIONUGczra5jOh
         Y3ad0hBUzZDq7QEjzm9/0lfpFPDWa0Rs5bjqe0BuB0895vzyf41xnRndisZfzEbfehxt
         kvWmoeaWhexiGLuBIRpk+20fA3jijNWvc/mW4S9FFO6MUC8HWYbE1blPx/CpydcIvTFI
         e0qi4uQISHK8dDOfyDt/h4J85TCyf52Zp4DDbmN/dsEF6Zwstv8Uk1bR6DKKAHSoR6oD
         2zgulheAh8R0kNj7Ai8lbkNC/5CIDv3LLdorgxXiTNDYkmFMYchvPARNsbWHPDXJ2PBL
         2Qbw==
X-Gm-Message-State: AC+VfDyMZbee4bbgrETV6aGotxs3tMFWB1MOISqWGWv41uRS5JI/+rNF
	hwaiXJPkGN9/h6EI28+ieQBbPF2ubExSxw==
X-Google-Smtp-Source: ACHHUZ6AczzJgn0jukYSUoArzTr5J2j1NqT4WAwXAJKUHqNocyexzS1v8DS8jQOGUTLa8kZtX9Ltbg==
X-Received: by 2002:a1c:ed0b:0:b0:3f7:948f:ad1c with SMTP id l11-20020a1ced0b000000b003f7948fad1cmr181688wmh.6.1686857065948;
        Thu, 15 Jun 2023 12:24:25 -0700 (PDT)
Received: from LOCLAP699.dhl-toledo.locus ([195.55.200.178])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c020500b003f6028a4c85sm28241wmi.16.2023.06.15.12.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 12:24:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/7] doc: document [DriverFlags] group settings
Date: Thu, 15 Jun 2023 12:24:11 -0700
Message-Id: <20230615192415.1718516-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615192415.1718516-1-prestwoj@gmail.com>
References: <20230615192415.1718516-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.config.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index b3dc22d4..190f2c69 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -378,6 +378,32 @@ The group ``[IPv4]`` contains settings related to IPv4 network configuration.
        will limit the number of access points that can be running
        simultaneously on different interfaces.
 
+DriverFlags
+-----------
+
+The group ``[DriverFlags]`` contains special flags associated with drivers that
+are buggy or just don't behave similar enough to the majority of other drivers.
+
+.. list-table::
+   :header-rows: 0
+   :stub-columns: 0
+   :widths: 20 80
+   :align: left
+
+   * - DefaultInterface
+     - Values: comma-separated list of drivers or glob matches
+
+       If a driver in use matches one in this list IWD will not attempt to
+       remove and re-create the default interface.
+
+   * - ForcePae
+     - Values: comma-separated list of drivers or glob matches
+
+       If a driver in use matches one in this list ControlPortOverNL80211 will
+       not be used, and PAE will be used instead. Some drivers do not properly
+       support ControlPortOverNL80211 even though they advertise support for it.
+
+
 SEE ALSO
 ========
 
-- 
2.25.1

