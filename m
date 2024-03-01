Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B48F3987C
	for <iwd@lists.linux.dev>; Fri,  1 Mar 2024 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304377; cv=none; b=GPTddVwX5dfbn8CMPzi4fBrqnUGl3aoshDsOimlIJgKJ6XVNbVdDL4972v061KrcP1eW5Bx8X0Ym6yh6/DZoP3SnvvRxD+x7P4Fnc/ta4SZd1e/E17DavofOFcq/AO6mwmZp4nqAH+kTnf8+/K6noap9/QclN9pF7IA/8GBdJ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304377; c=relaxed/simple;
	bh=0a75pKLePa5Jrx+vUYXOTDzRAEJ3ZIRgvyIsEEIOnb4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dsKv4cnb0Ww0VpFZ/l6QwkLFz+yNRoQPyIdSAzqxWNx01SVEdNJtfpRbWsIyYT4iP5oVZ0LCtFGXalWzIaq9stLgNRPi5bSKGxM5fribI/A+CGEoczrTX/A7ihVA4RhD1QeN3ZbHMidTY7w2HIJ4SXsesQmZ5xOp2FUk98nQOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vonhaugwitz.com; spf=pass smtp.mailfrom=vonhaugwitz.com; dkim=pass (2048-bit key) header.d=vonhaugwitz.com header.i=@vonhaugwitz.com header.b=byy4oJn/; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vonhaugwitz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vonhaugwitz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vonhaugwitz.com header.i=@vonhaugwitz.com header.b="byy4oJn/"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TmW9t3Mnpz9t95
	for <iwd@lists.linux.dev>; Fri,  1 Mar 2024 15:46:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vonhaugwitz.com;
	s=MBO0001; t=1709304370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=0a75pKLePa5Jrx+vUYXOTDzRAEJ3ZIRgvyIsEEIOnb4=;
	b=byy4oJn/817omB5jQZW1Ie5Kue2Qhb1p3iTBVkSTghHQK3fGkOuC69M9QX0zC6RoilbYXR
	+p+kssPwo2/s313n1pnxpGvfRSNUKrH52s5CkVErWB+vbt+ddG4dklKFhW3tD4TfGsSQLX
	MMHxBcw0IVnUp94Hjzroup8SPBGngWjDg96tKyE70OkGz2v8xzp02rVKqMYnYrNuh2/2qn
	rEdoC5/g4LKd1bdcvqwW426KABHFzK+QG/1A4TqQqkfCZDmOfS3dKoKASCeuadUBlvELzP
	k3CxXFi7VbzauxUBxt5j2U0sVfj2rM7TPmbpeyjBa/e3XUyy11skTIWj+22sDA==
Date: Fri, 1 Mar 2024 15:46:08 +0100
From: Hannes von Haugwitz <hannes@vonhaugwitz.com>
To: iwd@lists.linux.dev
Subject: IPv6 Privacy Extension support?
Message-ID: <20240301144608.GA25@magnesium.vonhaugwitz.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 4TmW9t3Mnpz9t95

Hello,

I'm running Debian sid and iwd 2.15.

When I enable network configuration and IPv6 in iwd config, the IPv6
address contains the embedded interface identifier (i.e. the MAC
address), even though IPv6 Privacy Extension is enabled for the device
(net.ipv6.conf.wlan0.use_tempaddr = 2).

Do I miss something or is there no support for IPv6 Privacy Extension
in iwd?

Best regards

Hannes
