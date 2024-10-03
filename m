Received: from zdiv.net (xvm-107-148.dc0.ghst.net [46.226.107.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF95A8C07
	for <iwd@lists.linux.dev>; Thu,  3 Oct 2024 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.226.107.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963266; cv=none; b=o+jAorDBs74xbaup+YH/0cxPBH1G7o4IaXNBvatcnTiTNVjpObFpJm/gsTnW3Ly0oVDg9xXATKQccUqNTIwRFZ/AivvgyJx26u9r6890Y8VwCnBpyg/CGuADKer0sGoMMy1KLjDHCmTVxjqgzLobKCixSN8UlK/OIueZUIRBI0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963266; c=relaxed/simple;
	bh=sYPtWFmeEwBca87Z6RNvdvzHF6JcOv6+65c9a9q7Fzc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=jWvK7N/ewH9CgVNxZ9oP5/CYXjDQpo+JuAP+OeK4knjVfQcs3XYSHHjEFMiToT2j7BpCgFFHIq2pmR98ZICpbtFAYzKDkPp6cpYtt2M01k11LugUjgZgK80QizFq2gGlZm32zYN8nUnNtMgE22/X3pEYRCRy6iW7e8TbZNkhneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zdiv.net; spf=pass smtp.mailfrom=zdiv.net; dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b=fWp4DoAA; arc=none smtp.client-ip=46.226.107.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zdiv.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zdiv.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b="fWp4DoAA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zdiv.net; s=23;
	t=1727963258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sYPtWFmeEwBca87Z6RNvdvzHF6JcOv6+65c9a9q7Fzc=;
	b=fWp4DoAA9tQZnbsMkbjQQoWMZpoECV5SmGgJn+KZ3HP1QUm5GeQJJRWobpECiQfBwM3WQt
	BM0Sokq+aA4II8GPxUB5SKlhbAyBUJu484AJrqiN3JaA7nbQEfL1u4jaHyc3QwRWMmwGv/
	nacXjV+bHHm3wml2fZJjXDxiZNpMdNLPIZbDjRXRLDcUMZjeHSJkmkbzerTIG7NhNNB5yu
	GyBT/1ETfsxKb9Hqzd235+sC/5sJQPn1AoMIop3DdamfnlEFT5wvjhM6DaXOHY74CtCkr8
	uo7a/EI6C0zrP0M0WpXiDIYApIslpW1dbnJDS9/8wfKN8paVd7cmSi+ZIqBk5w==
Received: from localhost (91-160-75-97.subs.proxad.net [91.160.75.97])
	by zdiv.net (OpenSMTPD) with ESMTPSA id b02b6d9d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Oct 2024 13:47:38 +0000 (UTC)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Oct 2024 15:47:38 +0200
Message-Id: <D4M7UPZY8KTI.179EILVKMUA3Z@zdiv.net>
Subject: Re: iwd 2.22 segfault
From: "Jules Maselbas" <jmaselbas@zdiv.net>
To: "James Prestwood" <prestwoj@gmail.com>, <iwd@lists.linux.dev>
X-Mailer: aerc 0.18.2
References: <D4M5LOG8MPW1.SYF1VD48Y3YH@zdiv.net>
 <afdaa1f4-5b24-4d33-962e-3b026b65c626@gmail.com>
 <ba4ea86c-7abe-4873-9ccc-44bc339d9ee7@gmail.com>
In-Reply-To: <ba4ea86c-7abe-4873-9ccc-44bc339d9ee7@gmail.com>

Hi,

On Thu Oct 3, 2024 at 3:00 PM CEST, James Prestwood wrote:
> I was finally able to reproduce it. Its completely timing dependent and=
=20
> I think if IWD gets restarted _just_ before the timer fires it will=20
> crash. The easiest way to reproduce it was to just disconnect with=20
> iwctl. Anyways, I sent a patch to the list which should fix it. If you=20
> have the ability to try it out to confirm that would be great!

It did fix the issue thanks!
I also was able to reproduced the issue with `iwctl station wlan0 disconnec=
t`
before applying the patch.


