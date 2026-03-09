Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE2922A1D4
	for <iwd@lists.linux.dev>; Mon,  9 Mar 2026 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075479; cv=none; b=Vf1jGJIIwWZtHjY4sW98YkWfmV+D8WFZWlRVA7EKM4a4tYxvEdkrqRbpsfiqw0+tVa0KsWcn0jLyRWBEBD/HGp6qUHnxRMzCsB882MnTsRMGz6bUAR39aFLdjpY5Q0++5WRv9p2j+vlkleEhMMeZYFMC3MTOlCME8sL0an9cyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075479; c=relaxed/simple;
	bh=6u8p6zn4KU1bQwkGLpHyUOUTWM7s9Pif7ojEnA9H5pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tbJLq08PtvqlCPwB3jBhuCZtDaj3mtMk1YExOQ/QLXZu3oVkYuVz83/s02CFhUpwvMOCXlaCajUVh7/onzZo7D9FpYEbDAWF37gb1Mu40SJhCN/hw2gBN3KsHlIOL+z5susHThdSGtn1ZEPEKmoCcG1PZbqQUkzVaagjvTBzSBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dz5vSbLo; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz5vSbLo"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89a1d7cc7f0so46971176d6.1
        for <iwd@lists.linux.dev>; Mon, 09 Mar 2026 09:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773075476; x=1773680276; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npHhCLSLqoVCoPEezXWP0XycP0D5hArDUFKa6rbvRGA=;
        b=dz5vSbLoWnO8ot1uS2wQS0/7ijfMOv+PoU+6KEKn3J8q+b2LPxhav0wk+OyD0L2CBk
         lRpOGMZUiR0tPazpOxDF9Icx2tZjoRbgcg3RUV4qg9S7Z7waci4IcZpE5IPIHmsDvI/W
         2Nc4fs96EZif8HNQY+KEHdCTzHt7W43TbFUQ+lyGpqFH+1ndt26DL+z3R6dz/0ruVw/G
         P8p/Ypw3RKIH7cvPySNUBvwa8sxLeOMAkZI59hLN+iEzswqNfUqRqaXc3AP9j8NQRYhS
         ZEdrhHuoXCw9Jy/UKSzL3X9cXyjOpa5Pm8WKCoi7WOH7drOLXjoKVRy+ajGcBjF4S0Dg
         jw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773075476; x=1773680276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=npHhCLSLqoVCoPEezXWP0XycP0D5hArDUFKa6rbvRGA=;
        b=Ft7Yl68l/mcyQ9DnuuZaTnKbFkBbdeMHgW/DyTdGw4VamUZJ5RuEiyG2DDqND7GZQY
         ZhSuXg/xFwbN+rU9cFpjyjyKuOTYj0O8Mk6MxLGpVDcfZjVsH8ghsaQJEWJYVNqRVzs/
         xbLfyfc8dNJfKNiWWLHJcnKHeceyKZPsW8496Is9yAA4thoMNY5bIoY4/It71a0hwKTy
         geCNw8CTeZDuW7zQcbEzCbo6S84pXCB6eIMOC7VRgxqLg2jeCUBxlUGeQArQpTcBBzY1
         8DJwbQX/LH0On2aAvE5rw7sIWvP+VKbdqiHOnoPFHBCeitYV2P6sZ5AZibC5TcIEnF7H
         kH5g==
X-Gm-Message-State: AOJu0YyeS1rR4zc23FTMDW35yIIUgwk2/TmLEVRlGRIEoQa+uvrPqxPH
	95ey87g0Jyu9+CEXpSqe68GmxUzuAdWpYCmhVk5sE+i+bAlcwN7gxk9Gu5SfJg==
X-Gm-Gg: ATEYQzyUhT/cylLgdkAS1wQE5Mfu7kmvZDmPYYwoB6QRaTVHY99u78aizQIXgyCM4tF
	TNcCSmUVdZsma7o9XEyt/PWqnSPSISkdDW8xg4/WsSSKWt+x833sZQ2H1PZipGxFF60RtE2B7nu
	27Kf0xfD9z5V1S43G6sAbpzEqcw7xarfrI73enaFLFdU135ejBQ1slMzXbZh0KDlJ77Dq8yppaU
	nKcq/7lsy41c33dpUW2B8eXDGReBPYuu2u8KQu8JAiNxIEDS786NANxhGzdJ75Yl8xDP6gsQ9WI
	VVtXT5ZFagUN8mHYmZzaBZ8reBWohb/DHZFZBsdsA4laZHEq4T46xBtM/sX5DdXDQXLhY6ou+I+
	/yFEBGekqflZgwFD0mjpq29O+MaeCs0HoCplHjnJtIH6wYa1U46bDWfdp0iLE95wSaoM5sJr1Eq
	l60mc9pbbYSN8ZrwTSCjvfad4R5yb45tmGXOroebr6kYFMKgMjsSS42LBL91Dq1HdX
X-Received: by 2002:a05:6214:29ce:b0:89a:c8c:3121 with SMTP id 6a1803df08f44-89a30a9e913mr179697776d6.40.1773075475795;
        Mon, 09 Mar 2026 09:57:55 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57a4b079sm1704576d6.20.2026.03.09.09.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 09:57:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 4/4] handshake: clear expiration of pmksa in _steal_pmksa()
Date: Mon,  9 Mar 2026 09:57:46 -0700
Message-Id: <20260309165746.2073055-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309165746.2073055-1-prestwoj@gmail.com>
References: <20260309165746.2073055-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pulling the pmksa out of the handshake object (to cache) we
also need to clear the expiration within the handshake itself. This
will prevent future attempts of setting the PMKSA into the handshake
due to the logic in handshake_state_set_pmksa():

/* checks for both expiration || pmksa being set */
if (s->expiration)
    return false;
---
 src/handshake.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/handshake.c b/src/handshake.c
index ef1a8220..41192fdd 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -1267,6 +1267,7 @@ static struct pmksa *handshake_state_steal_pmksa(struct handshake_state *s)
 
 	pmksa = l_new(struct pmksa, 1);
 	pmksa->expiration = s->expiration;
+	s->expiration = 0;
 	memcpy(pmksa->spa, s->spa, sizeof(s->spa));
 	memcpy(pmksa->aa, s->aa, sizeof(s->aa));
 	memcpy(pmksa->ssid, s->ssid, s->ssid_len);
-- 
2.34.1

