Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1A17A
	for <iwd@lists.linux.dev>; Thu, 16 Jun 2022 05:32:39 +0000 (UTC)
Received: from workstation64 (ip5b41e765.dynamic.kabel-deutschland.de [91.65.231.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.archlinux.org (Postfix) with ESMTPSA id 65C7B1102CF7
	for <iwd@lists.linux.dev>; Thu, 16 Jun 2022 05:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1655357129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=J4ArP9o3JM/jqmcDjCIMxGRMzRIUkNo8gdhntihU9qfkFwGpP5HRWUC+fR9oRwG6M6BXaf
	MAWZUg/ieump/xBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1655357129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ujCkJVfM4ImdBB/R2vxGFuIm3lxhXk/sajOUjyBvGgaIWRnmL/8zehyVAQGHzZM6mScCyY
	dTyXm61KoI75m4+yBSduiXhTsmKXDU9eIqoqSekQuCI5jciAgAbMxxioMvqkz0VVWo0yxO
	NdBVUp4SnYBslK+FLRPCmUsJWxmGPTUsqz8rZhhhJE+swgDRaT8R2iPz7i59esjB1GyIAz
	vP8YtDtjqH9dZjW/kfP/9sYKH8BwYLRysh5/zwBLU42JMrF+tiU7o5BTDE/S0+C2PzDNpL
	FvunxK8dmpq9S6loCpJMh/tDRUf/DF10Gw/Pl1L3mjCZOAy7pEC724yQSCoI+H0gj2svFh
	iv/mPFJHqEM+ov0Ub7ZkpvWXbNPx6/WedpzDy9pSCk3uenaWM7LUnw8CNGCyKnzjoDI9hS
	mGDgrO6LVR696E0lrygMYP57rSwCI13Ad5pzkqD4VdDy2Fx3uE3USORkAtcS4KLe6VYyG/
	xUjVeCbS9mV611dAqDXZfUfoxD9d76TLJhjGPImtqW2Urm5nf+X/3yTBsHTLG3Ecudt8W3
	3xB07MFOUklGgZFbzv5E8K5Sg3oJT55JJr7KEdmtjEbDMneEhozPrrj+TOtw5D/8bG0/rI
	hS3MHOs4KofjrAB2GIejD8tPeBrtUNZJBBze6DF6rlugUSSpbTxHc=
Date: Thu, 16 Jun 2022 07:25:28 +0200
From: Andreas Radke <andyrtr@archlinux.org>
To: iwd@lists.linux.dev
Subject: subscribe
Message-ID: <20220616072528.59098051@workstation64>
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

