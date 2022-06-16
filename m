Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14646AA6
	for <iwd@lists.linux.dev>; Thu, 16 Jun 2022 19:58:07 +0000 (UTC)
Received: from workstation64 (ip5b41e765.dynamic.kabel-deutschland.de [91.65.231.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.archlinux.org (Postfix) with ESMTPSA id 232F91108A7D
	for <iwd@lists.linux.dev>; Thu, 16 Jun 2022 19:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1655409485;
	h=from:from:reply-to:subject:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ruW4UFXxVsMKbdPMnmxDaTv+16pA7U93ISteQk0ZEwg=;
	b=ixp7hEpfY3MTkqcI9Fc8ME1oRaGwSnPxngeCJem2xaIenwoAlLZdIhhISZ0sLM31IVFNHl
	u+EwJfMcI2DJli/6OUDXTowqOqj3S37f68UWBkhKV3XLcDN6mWY5L0q54Epe2SNjHqRoWc
	XttzjOMsvzCrzW18S4ri1T/ozYUzaRR8sHmm+5/S/dvHY4xzfkRoduGJULqu8Oyb68mZm7
	TvGRkPLbV8LuRXPBz0udpDG6R9k1D5YCfkLU7i9UtLRygQrjUB3c4yl7HzFTU9gViOyV1g
	jUn+Nzz8D01oBeVGwtAvRz3BcVXvBs/hbpdWEpZORaSnqq+kA0zUjiQzSJcJMazq9qDFqD
	FJDx6ukEet/G92hfO/F4UA2B3AFeSEzUe3QGFIPN/zmtRgMgM2nDrGqQ4/mUwkFVPARF9X
	Nf1lzDOopV3rHysZQktDpFkGTm14RhK6uAuFGSwaCIs6F0h1oMjZSOX+zsako+q9uRzleP
	cBgDM/esFAqf9IeBl1fksBQu+7id2n2WDjON5/1p3qw2DEjiFyoe4g8I4Uq9R26ho5QxWk
	iP3lCOg5tIn3TQtO1EYQkJO1qPvW1Yb1nInEzgmTiz/wcZZjwC7Rql0MYSaWzKpp/YKeKG
	2W8O/a/1XbSzaDa2xxuemnZ8QrAU/wYnzNaGy6jAv1xtc6ismC+Gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1655409485;
	h=from:from:reply-to:subject:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ruW4UFXxVsMKbdPMnmxDaTv+16pA7U93ISteQk0ZEwg=;
	b=wLC3UPWgzZI1nsTWS9OLQ/g20s2pYku1RT6+B+/8fWYZwOV0UeZIp3FC4jPDIoCFDSaCuc
	PxmScmjFlzFd+7DQ==
Date: Thu, 16 Jun 2022 21:58:03 +0200
From: Andreas Radke <andyrtr@archlinux.org>
To: iwd@lists.linux.dev
Message-ID: <20220616215803.579ffddb@workstation64>
Organization: ArchLinux
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEXLVzlCOzajNBsxMDJ9Rjo7JB1CJx2jo6JhMh9CPj9gFBAcGRUvqpyyAAACVElEQVQ4jWXTvWvbQBQA8McRSMeqwtQhi/LQcHgTVwghi+sKIncrhRCSKZQY0S4pGNTgycK4D3UymUyXxhAQ5ymEJJD75/pOX1baNxjr/bj37t1JsFw47VjsVH9guKxzHWMeHGf5H5xx3phmKQwXTrH60DxofWvunNYKC7vmWXMYE/xTyjznxLE29y9g0TE5hhxzY3YasDvcfUxhi+Hjt7oLDMstnXgADJFeV7Xgqlj6sAIOrkba1GB7dB77sH3J5EdZA/ZIOjFAYgF8f/2pBbspwDYUIX7dVVAcUwp1iKgNx224b8Gp1wCGX1pw0oBA/6LVvA2ygu8Mr/NNKVGDvVrEFkSfSzjgH3zFUKGg4xL4Yrqe8ACz3GPa2opOS7C9PfQEH+wKMdOzSE+bYxcrEHyrGvXZCZG+aeYQwjbNUrg15jHOpg3YHiBzANLxBa02k/dFtd00o5l8AViBPwApN/AGK0A7uXQb6BKW2Z7HA+5twOny2PiHbQVIe0qp+vXpIs/GL8ogR5lNlaNcF5YVSJ1qOtVEcycIGnDQ6+XY07nOsxvXDRxXMbhcMQWpPUlZnmfnDmcUQ9EqFQJ1KrOvOZ3bFQwBQ6BSnkT0NLcgN7AJBQfKRmRBppyf81NRqoTBAAF79tuZOkWigdCeBtpKqgUHRyIc2GvHotIGnkIRsnCeZi+BxyAaoKT453UN75Q6DD3wiWKiEc3GNewr9fuHvXKaj0aj2TRJ3tfwdtK3nxLvaBSH0ThJxiUEyWS/eDVZZmE0STg+WDhKJk+XdoiwiAKSK/UXmpn5K/owqOUAAAAASUVORK5CYII=
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=andyrtr smtp.mailfrom=andyrtr@archlinux.org

help
