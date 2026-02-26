Received: from stacey.r0tty.org (stacey.r0tty.org [135.181.93.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF94438E5F2
	for <iwd@lists.linux.dev>; Thu, 26 Feb 2026 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.93.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772100741; cv=none; b=fPeETWkrlnhrZyq46ia7qHXI+KSw3UF0APEVHR4XT9x3ApWdA0qGRPNTDu77tM05aOrF2rP+2R5H/TjNZibJJvgUPgmNhFvJ6Bi/SpPQMdOx752S2NqTcj2bop/4bJAu3hhGMlJc8hgngTNGhXD2aGzxEEnNBYC4rWVzeby/AO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772100741; c=relaxed/simple;
	bh=6uqkWonPXRv+3E5q5OyQwxXKy0YLVVZWDH0p2b2pf4I=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rZcnoyZxxeLbxB/o1Wm5tYd1sRWe8OktbkfSh95c2LjaqYOaFQNrMwVajYoY2MrRyfHR5EAfJe2b9ha74BCLeCVi7KoeeqXMbi6aFhepjSClnjZZI74Vx6X32Lsx5mPomBCx+Egqpi7pc4jphYXNReT0Q0+JEv5bYxmEC/iQG0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xx.vu; spf=pass smtp.mailfrom=xx.vu; dkim=pass (1024-bit key) header.d=xx.vu header.i=@xx.vu header.b=gQLcm+bc; arc=none smtp.client-ip=135.181.93.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xx.vu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xx.vu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xx.vu header.i=@xx.vu header.b="gQLcm+bc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xx.vu; s=20200309;
	t=1772100737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=MolpYKWST7otfEJUXZcbYsTPs0blGFN6OWTDkINHVkU=;
	b=gQLcm+bcMVpHgerIUOI+ealrpV3tVQ0ed7a/rZBCD96G2fnx6Xlw4wO6BPzCZofrMk42hF
	EGaoyjrqVulFRoMNhsKnvfmjHAAC4c33H4q5Mb8OhLswyf0Fxt4qtbJEUY8R0rp3HbG5K9
	1+shFAj5oDMs/xDbczHJRUonQszel0w=
Received: from stacey.r0tty.org (localhost [127.0.0.1])
	by stacey.r0tty.org (OpenSMTPD) with SMTP id cdd349f1
	for <iwd@lists.linux.dev>;
	Thu, 26 Feb 2026 10:12:17 +0000 (UTC)
Date: Thu, 26 Feb 2026 10:12:17 +0000
From: Alexander Huemer <ietha0weefee@xx.vu>
To: iwd@lists.linux.dev
Subject: iwd not honoring AutoConnect=false
Message-ID: <3p56uq4uboudnyuit6hlc3d4jvfllv3y7gjyor72vokio2msmy@xpfpjfqdknj7>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

I am using iwd 3.8 with systemd-networkd 257.9 on Debian stable (trixie) 
on an amd64 machine.
There is a wireless network with a PreSharedKey with a .conf file in 
/etc/iwd that I do not want iwd to connect to automatically if the 
signal strength becomes better than an alternative.
The manpage iwd.network advises to use

> [Settings]
> AutoConnect=false

I did that, but do not get the desired result, iwd still automatically 
connects to said network.
The journal doesn't mention anything that points to why that is.
Am I missing anything obvious?

Thanks,
-Alex
