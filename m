Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F09F393
	for <iwd@lists.linux.dev>; Sun, 21 Jan 2024 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705877634; cv=none; b=meDHLLIwzoZKPSZnp2ov7wM/6R0nL4ixw5XTqU1pNhEIx8C/C78fAKE9mxtdjCqH53j5GNOYkr8OY8XozNGHOrvDMC6SgBLB7D06fkmuCrEf5fE3j7r5OnP70Im9F3HDBa18E5Yb/2U/5zgAGDsh4lX1dNfYUjtRuS0laM2UWYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705877634; c=relaxed/simple;
	bh=T6kDnmTgUt15FNWjAIYHskiR9wXtG8cBJaGMTqdaiQo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cTmkZWqUThOf/nQn0K7ZSdbJ6nLxHVujz//nEokVoay/O8PSuLCvL1p9hKGUraq88chDyQBVjE21bzRRzVPk/hZicadGlsNdPJoALL8KjS9576nn2W/0335Y6OS9rbm0ArIo179C4vk61daWZiFh//2YfBlT6E/qy7hL5lVGLJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=espindo.la; spf=pass smtp.mailfrom=espindo.la; dkim=pass (2048-bit key) header.d=espindo.la header.i=@espindo.la header.b=SWapw8sq; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=espindo.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=espindo.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=espindo.la header.i=@espindo.la header.b="SWapw8sq"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TJ7tt4fg7z9sWs
	for <iwd@lists.linux.dev>; Sun, 21 Jan 2024 23:53:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=espindo.la; s=MBO0001;
	t=1705877622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=T6kDnmTgUt15FNWjAIYHskiR9wXtG8cBJaGMTqdaiQo=;
	b=SWapw8sq6o6cak+NqoUnNy3kn1bOt9JLIM4FbDjBifXwxB5YoIXWf2pGLNARX2oKhgRML/
	t1S4F2IwX7CanKbBm+c3LXMq0jxSaSp1nfehim0IgSfcORhb7xuIQZp3JS7Q6c+DdUym7v
	2oN70K9U1pbrTEs9hVCDEMK2Y9GrtUbmqDeF+bP+Fy2Xo7iM4Pr4iuIbfwH+qMHH2vU1uZ
	uD0LrUm/cI1XsiYLQ4th0F5+JFigxJXo1ZXd1d8N5QbXuKHdmU4stUAwYqSi94TCd5tX+X
	eYdfMRQUMoiGfNHodi5YZUPKirE3GfG7ULAn/7CINWluVpjN7WbPnnin0985Og==
From: =?utf-8?Q?Rafael_=C3=81vila_de_Esp=C3=ADndola?= <rafael@espindo.la>
To: iwd@lists.linux.dev
Subject: Making udhcpc get a new lease when iwd connects to a network
Date: Sun, 21 Jan 2024 21:53:29 -0100
Message-ID: <87h6j670ye.fsf@espindo.la>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

I know that iwd has a builtin dhcp client, but I am using it in alpine
linux and would like to use the same dhcp client with both wired and
wireless interfaces. The default client in alpine is udhcpc.

As far as I can tell, the impedance mismatch between udhcpc and iwd is
that udhcpc expect commands via unix signals and iwd send property
changes via dbus.

I wrote a bit of glue code and posted it to
https://codeberg.org/espindola/iwd2udhcpc. It works, at least on my
laptop, but I am wondering if anyone knows of a simpler way.

Thanks,
Rafael
