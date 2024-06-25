Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B291482F8
	for <iwd@lists.linux.dev>; Tue, 25 Jun 2024 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320809; cv=none; b=V9+uStsPyOevcnYtaoW88B9OJMPB558N4TLwYFVgpu/xsCBpr862/SEzW8dvx3uaGy+wk8TCFJs5wO5lU9HrVQHnlgzhLWEQReG7G7wS0UT5BSycZGNiKDRaEkmrGzH+yOhyK6foK1vFZUHRtmhEQ4XQqFzKxT7hHVaYX3+vtZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320809; c=relaxed/simple;
	bh=2/YIDZntCC+bKNXCrqR05azYPO5cmwgfNe7FvsobFVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E2vkAypDVoOhWu9Fu6IiZ/Hh3r51E0XhdXE10atYhgK/zJZIvSje/NVScz/0NsZMuJMXrd3bozvIPJnfqVP4NOMGG4rLOu/yYEMwoR/ztDCwVzEDz/ALGu2W9oSlYKrgZcy0CZ8y2PiC6taLp+qAxMtJrP733KX756F2vD9V0b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNFQfYun; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNFQfYun"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f4c7b022f8so47480985ad.1
        for <iwd@lists.linux.dev>; Tue, 25 Jun 2024 06:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719320808; x=1719925608; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXiAgG1s+6d04RN5hd5w1iSdbqu45wAyYTOnPDQxZyM=;
        b=CNFQfYun457D62Xaosia29Ojgy6vdvAYkDCKD+QzOwODm+HPzOaM0jy8aJcxuEW+ed
         x84n/JYvaEFhSM8axWs/qnZVKkYOpUgGBWikD6RU/b7kJj3bwQUMwvU1Ey5uU91ufe5C
         ZjlD09yeTQLh6VjwkfL5SMwH9tqmbZpG5izJ36H4xFcJ27mOW69odQOCOvGXnN/BPCum
         0l+b7KrOeFOcL3wwCcOrVg9LjlEAdqodOF88VGzrkFxD8/p5jcZjEHTFhvThcmlDKnix
         uvjw0+UXQAL1afwKZM4ERNZiQ9P0YX566TQn6NokiETa6lM0wnk74KNVjxuRv3X6r5I9
         Hr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719320808; x=1719925608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXiAgG1s+6d04RN5hd5w1iSdbqu45wAyYTOnPDQxZyM=;
        b=aVEdZGOlHebhbfzwhVfrdNvP6uGCjzeWwCdWzLNBzXHuuUI7LrnM4m1xXE7yT+L21U
         qpC07W+nK0sGnTgcIeNIaTVW3+ODfoGPqKeaLVrPIsXYfpCLeN3qVP7vXDqMlL9enaPU
         eH7MD7/8S/ja64cOVmBrL5p38aNQSTuJpuaxwrwA7usi01kabEjkv7sEigjgI1xGg6EG
         bjTPRoe9YCWIau9yZRDg5ar7w8Vv6QbezWVzNJmXqfLCOItCTDzdame0qjr1tgwXpPXH
         vcis4TqRHjRttXJD7Pv555SUt4Qhs/ST98qceTkV0kPlArivMxmVVL+a3Cm5cXqXukRZ
         mLHA==
X-Gm-Message-State: AOJu0Ywk+WvRUKJH6qDF55E8sMD4qwlELEuuiuHL+HgmvCTXGgTf72U9
	VcIE7W6Y9qtSzqKixsVF1mj0sl0QcGnp5arWYOiKHiLVDvJPiwY6OR2A8Q==
X-Google-Smtp-Source: AGHT+IF07DgU+eGZOmeyHUxDD5bmEv2fPPScoNGsjqPISdJ17zkYNgZ1CSzIpkb7qH7jXCZ0/5sVtQ==
X-Received: by 2002:a17:902:e846:b0:1fa:4b9:d002 with SMTP id d9443c01a7336-1fa23bdf6c0mr98149675ad.23.1719320807714;
        Tue, 25 Jun 2024 06:06:47 -0700 (PDT)
Received: from LOCLAP699.localdomain ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5bf2sm80778305ad.189.2024.06.25.06.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 06:06:47 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/7] station: add debug event prior to sending an FT-auth frame
Date: Tue, 25 Jun 2024 06:06:23 -0700
Message-Id: <20240625130624.385553-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625130624.385553-1-prestwoj@gmail.com>
References: <20240625130624.385553-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/station.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/station.c b/src/station.c
index 1e8846b4..509d919c 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2449,6 +2449,8 @@ static bool station_fast_transition(struct station *station,
 		goto done;
 	}
 
+	station_debug_event(station, "ft-authenticating");
+
 	if (station->connected_bss->frequency == bss->frequency) {
 		ft_authenticate_onchannel(netdev_get_ifindex(station->netdev),
 						bss);
-- 
2.34.1

