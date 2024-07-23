Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1DC14D2B8
	for <iwd@lists.linux.dev>; Tue, 23 Jul 2024 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721751533; cv=none; b=oS1aAjDJ0h/xOFWvgLa7hY1UcmQrIdi7e2ayzzYVCzZBQ2OybayWDrMiEUWzx2mZ6q7mAqoIU7AHfRVpxRRMsljATR6HhDOFAZDcJRRhKlG5SXk5kg/bgrExn6/dTJQOklXvyndEKKk1CQ7hrd9KIEzAputqXLN7+8e9kUqN9j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721751533; c=relaxed/simple;
	bh=Qn8JEz9WdN9MWUFOcp3TTZHko43Qz+EjX3XYAak4Qo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DTxdmoxOButfvc75G15rw/W3SPze7+AILlgJorSd22NsIvhrBRqxLy1VXyCleFs1OwC0vw+Q6qcqwYNrRC8ePoIEHRKNTkMIiRi1+32lw2zCibc9orvxjH9Y39eIC4nMhxUr6hy2CS92+4zhrQGv5g6eRLl0p/tatHXuW2fgGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaU6iILp; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaU6iILp"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so4651308a12.0
        for <iwd@lists.linux.dev>; Tue, 23 Jul 2024 09:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721751530; x=1722356330; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=brg1EiqRzepYxhQhuWupQOyQJ2emair7v+KGElODHh4=;
        b=IaU6iILpYuub5JfrWEEzzNwstsYkqN8uMitOVQxcEbsKsMerHERk0YWeVAkaC69bSu
         ljsjJMXlpNhaN+Tkgo8DyLLLsQnUhHdOCW8L7dbmLEH9+NpQwD8AUnJwIXUWTVfFUOO/
         PzHkxyKSOQZrNwXjoFcz/iR5NyVlJ8i1GySn+i1Ynszflm/SBzB/pLwaQXmgTN2taPJN
         kihDyLYOdmMXGxsih3mNI7FSPDWdQzLQiKukOybz0yot27ViPuRkas285vgEevHbwV0u
         U6JUtDd5kxpO+Ws8qqgaCFPyaziX29L6ee3eoSFvUZokTOXJjT6vp9aNsz0/ihVw6cFI
         dwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721751530; x=1722356330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brg1EiqRzepYxhQhuWupQOyQJ2emair7v+KGElODHh4=;
        b=nHQwx5kxcBnzmo65jpv+pXHHprP3sFgwoiWCTbfKg19vGN0Be3fUg2SoqE7GcTNhNn
         xAj9dTNrd96r1giOBcLAT8XSU5mhB332/5KtpzMx+IKe5b1kQwHZL7HZ/cUWF+E23WfD
         RHk/hn9lH5+fNaQklVQVxfEtrDmuWTx/PzsU3wBpTwTe7txiAOuNhrWp2xrPcePTt2ww
         zbRHxODyXL43J3dUgxAbNvAkEeeWfmv1lYqxAjkdqawV124DlNELIa6Ksv3QM/kBqp7P
         qUX8jRR8DAs1zh9WMxgzdVPL88xQ/2QLcjPKZf9wdnKN4OyDf7uHG5bb6JrvZbzMbDXX
         jAhA==
X-Gm-Message-State: AOJu0YwxUzOiAEsDpn9KdOm75L0ZKIs0KPf/l+bXtpscMaBOQKqzA6GT
	lQUsQzssn3mvXTbWVgEwy5AAkDLrry/BvvKbE8hAyShpuMEMcK4+nrjW5j21
X-Google-Smtp-Source: AGHT+IGQzwP7xZ+69OTYz4oqn/Wagp+wC68LjtVwWFY0ZAaMg5h/tcPfIiU47FfIpKzfwNHfnvLtsQ==
X-Received: by 2002:a05:6402:2682:b0:5a3:d140:1a46 with SMTP id 4fb4d7f45d1cf-5a479b6e59emr7700570a12.23.1721751529990;
        Tue, 23 Jul 2024 09:18:49 -0700 (PDT)
Received: from localhost (95-24-2-131.broadband.corbina.ru. [95.24.2.131])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a7661b26c4sm3857842a12.26.2024.07.23.09.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 09:18:49 -0700 (PDT)
From: Yuki Sireneva <yuki.utk8g@gmail.com>
To: iwd@lists.linux.dev
Cc: Yuki Sireneva <yuki.utk8g@gmail.com>
Subject: [PATCH] client: use display_table_row for IPv6 in station
Date: Tue, 23 Jul 2024 19:18:17 +0300
Message-ID: <20240723161817.2191843-1-yuki.utk8g@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPv6 address entry was not updated to use display_table_row which led to
a shifted line in table, as shown below:

    $ iwctl station wlan0 show | head | sed 's| |.|g'
    .................................Station:.wlan0................................
    --------------------------------------------------------------------------------
    ..Settable..Property..............Value..........................................
    --------------------------------------------------------------------------------
    ............Scanning..............no...............................................
    ............State.................connected........................................
    ............Connected.network.....Clannad.Legacy...................................
    ............IPv4.address..........192.168.1.12.....................................
    ............IPv6.address........fdc3:541d:864f:0:96db:c9ff:fe36:b15............
    ............ConnectedBss..........cc:d8:43:77:91:0e................................

This patch aligns IPv6 address line with other lines in the table.

Fixes: 35dd2c08219a (client: update station to use display_table_row, 2022-07-07)
---
 client/station.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/client/station.c b/client/station.c
index 1d958ef2..16c86dac 100644
--- a/client/station.c
+++ b/client/station.c
@@ -175,8 +175,7 @@ static void display_addresses(const char *device_name)
 				continue;
 
 			have_address = true;
-			display("%s%*s  %-*s%-*s\n", MARGIN, 8, "", 20,
-				"IPv6 address", 47, addrstr);
+			display_table_row(MARGIN, 3, 8, "", 20, "IPv6 address", 47, addrstr);
 		} else if (cur->ifa_addr->sa_family == AF_INET) {
 			struct sockaddr_in *si =
 					(struct sockaddr_in *) cur->ifa_addr;
-- 
2.45.2

