Received: from mail.pappacoda.it (mail.pappacoda.it [128.116.175.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912E2574
	for <iwd@lists.linux.dev>; Sat, 29 Oct 2022 15:17:08 +0000 (UTC)
Received: from [192.168.178.136] (mail.pappacoda.it [128.116.175.254])
	by mail.pappacoda.it (Postfix) with ESMTPSA id A408D3CFF0
	for <iwd@lists.linux.dev>; Sat, 29 Oct 2022 17:17:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pappacoda.it;
	s=20211226; t=1667056625;
	bh=6qg3lPAj5goHcPlYD/Oa/os9EN4ZG1CvpQxbenvegC0=;
	h=Date:From:Subject:To:From;
	b=o0EJpQDo+gpFSddmXMyBRSZkD/G1V5JLTMeNZVDPSAXXyVYEQdPtocM+EJgnX5Iki
	 Gf81MifklGKYI8mYviTTTMs65aayQWF4n1v4uBd5DRFjtG5cOOP4J4PcJkomNbmp+a
	 ZP4ygzm6fTlSCqe/DLYuPf3oBWHb7wGWzRjJ99j+kSboXqxzW/NGlIkCMeIcyrHZM4
	 3TdHyyYtsdISTl+nWuJnyV9xg/+F33ZU+7KYXmSVCf/G4bDiFqqeuolFWNrUOP7iZ6
	 pSsQQJdnSMoy7PcBpXRL6RY8NzUgXK9EqrKXy2RECZupYg8v1C/zbHk5OYTvVmor2S
	 0Q26Q0ztyde0Q==
Date: Sat, 29 Oct 2022 17:16:58 +0200
From: Andrea Pappacoda <andrea@pappacoda.it>
Subject: MulticastDNS for all connections
To: iwd@lists.linux.dev
Message-Id: <A4TIKR.5DC9OCNE90W6@pappacoda.it>
X-Mailer: geary/43.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi all!

I have a question regarding the usage of iwd, specifically about the 
MulticastDNS option. Is it possible to enable it for all the networks?

The iwd.network(5) manual page mentions that one can enable 
MulticastDNS for a particular network, but it also says that "The group 
[Network] contains general network settings and any network specific 
overrides for global defaults defined in the main iwd configuration 
file.". Unfortunately though, setting MulticastDNS=true in 
/etc/iwd/main.conf does not lead to my desired result.

I'm not using neither systemd-networkd, ConnMan nor NetworkManager.

If this is not the most appropriate place where to discuss about 
feature requests, feel free to redirect me to the right place :)

Thanks!


