Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8CF55894
	for <iwd@lists.linux.dev>; Mon,  5 Aug 2024 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866846; cv=none; b=V/NqaE3Pxxt77PghfysgjVYWdfuolMsDZjQaDjxpvNPwDfknXsUBo17xMxEK6rBqm4QMOoUWPfhzLdf5Rt8tIRPrdoIi2JKjGoa59NCITmj+3ck7MzYsGV6i9gTZKowGZfQJf6TDQGJ8K9PUWbNrt0sTlbyt/csrbRTqBUN81mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866846; c=relaxed/simple;
	bh=JLQ+Pb/EmccRoKEoC56+wI4QY9Ds8GnYO9r6iLs9cB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuBwK+XRlnoET9xx+R7nw6cVn6oJtUiF8y2jI65WySzvKX9CRrwmQoUQqjKKUfurpdiJm52HYcSiTkBkyg545Thqn/1zG+fhWROkvI/abFL4VSoY1oJCkFec7HsmSdhGJuyJ0PlZNPK+IJYkUvB/5moWpob2kKXjI9bq4Ta17fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnl63DSL; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnl63DSL"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db2315d7ceso6207404b6e.1
        for <iwd@lists.linux.dev>; Mon, 05 Aug 2024 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722866844; x=1723471644; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xx+XprITqFGTjtQ4SmUv/xE3MhlLmwzNRrABoCGND4k=;
        b=hnl63DSLv0cNtqKZKKXbRr1hRJFn4HvG4tl2nekAcS5b2vG/h9kX4W2j9dRGFpAdFn
         4bsYrb8bFKgasQETxkZ/17hJFmuQS4pjz0ITMdb4tpXvkBX6YT2O5wyZNItvvovjph3R
         6BIzE/eu8pwBmksHiN2cyO7Ss5iRULYlMRxhlt6yH5wT+ljPw0qG9QEPdhYeWi9VkIG4
         Iso5ozxIFXVIKhv+s1lcpMW65ccpR5rCyg/96k2U/zyBZPdd1vW2NnnTjICOAniZrKSE
         UudRvH2OtuJ0Ky7coj3Qcg50MYN6q+yQfrS6fq8Tst+IHfGKgD4SKNa+aN7fjAECoBpF
         zTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722866844; x=1723471644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xx+XprITqFGTjtQ4SmUv/xE3MhlLmwzNRrABoCGND4k=;
        b=vZpu73Sv+QWRYQ7HV+VRwZaanqHxYe+mHFbLrsslOp4jmEuVhBsZwEvhI/0slTrFzW
         jsFIxLpCxIL//nNwJpAX0Sh4IYQQCF5T4oroRpjnS+las5UbTFSsR+6jjn4wWq6FLXKz
         6WfWQr4zSxzBWzEUYw/7nJ8S+lW2311Z4GbGs9KJH773K/3tGr0PWhrN4EPkAKMNeBZP
         qi7+xluTuCrfvjai8Oi2CS5v/l7lpJ1v/y3XOos7E2D9Wx9rniCfnXJm3zawcizOVdvS
         HEu5iHQ2XJa9FkQvkD2U0VJyocXbcQZ1utrOKAnKkZINuWaCbPi+ImQRuSY5HIb2Qxqo
         WELA==
X-Gm-Message-State: AOJu0YyurO/XTLhCIWtru9mHq9QdksQd7SlWQt6dp58uoTeyqOrrAwVl
	FlNhDXoF+c/YLZuOtlFsNLXTs44C//M+Zi9mriGBa9n3WjQmwmS9LSYo/w==
X-Google-Smtp-Source: AGHT+IHUtwk6vcgM4Jy/5QSt2kspsLsO43Zp06KoGwL3jjvJow6S5bNtM8me4UmyqTOr4zJhCrFm1A==
X-Received: by 2002:a05:6808:1206:b0:3da:4c28:6697 with SMTP id 5614622812f47-3db5582e23dmr14935889b6e.38.1722866844389;
        Mon, 05 Aug 2024 07:07:24 -0700 (PDT)
Received: from archdev.attlocal.net (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db56361a88sm2654172b6e.4.2024.08.05.07.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 07:07:23 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/7] monitor: Mask flags from attribute identifier
Date: Mon,  5 Aug 2024 09:07:09 -0500
Message-ID: <20240805140721.57518-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805140721.57518-1-denkenz@gmail.com>
References: <20240805140721.57518-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain flags (for example, NLA_F_NESTED) are ORed with the netlink
attribute type identifier prior to being sent on the wire.  Such flags
need to be masked off and not taken into consideration when attribute
type is being compared against known values.
---
 monitor/nlmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 941992595412..214246ea72c2 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -7762,7 +7762,7 @@ static void print_rtnl_attributes(int indent, const struct attr_entry *table,
 		return;
 
 	for (attr = rt_attr; RTA_OK(attr, len); attr = RTA_NEXT(attr, len)) {
-		uint16_t rta_type = attr->rta_type;
+		uint16_t rta_type = attr->rta_type & NLA_TYPE_MASK;
 		enum attr_type type = ATTR_UNSPEC;
 		attr_func_t function;
 		const struct attr_entry *nested;
-- 
2.45.2

