Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C0814276
	for <iwd@lists.linux.dev>; Fri, 15 Mar 2024 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710540605; cv=none; b=DBh7hNWMBfG7HwGyo0ZbGHZ7yhoFFlm15JJm1/x9xC7189gLRRHuCCm1gVrdb+Cl9/RmYZxgT44qS+qilHaceUa0pvGFfx+6xKccmcjgSD3lpi0eEx1KOS/fCrdV+rLXoSH/EmcsyA3BJINPlD+M/uieMe6ZtL4Jeq9Jem+48zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710540605; c=relaxed/simple;
	bh=da+46mGKcQI94zLwJl+SbuQz8oTQObvsmu8QWJYk0hM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=a2S68ctff/y+F0j1vvgocTbjJngxKJguw7gc2cFsIHAmqZmI4wpD/3YmeOoivkI+L+bXTeK09B1HiMOSnZ0JJIaK/JV0TXs3kpQG8XSR8iHGz3gXRdNmEdLfNM08SzH4nJ4VcJd+9PTod1VghwfNuiVQ02Z9iI6R8bGVc2XQGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b=pri4TvGF; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b="pri4TvGF"
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=craftyguy.net;
	s=key1; t=1710540598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=da+46mGKcQI94zLwJl+SbuQz8oTQObvsmu8QWJYk0hM=;
	b=pri4TvGF/jKxsSN39gNOCLRIlfI44pBQ6lOPRbraPByR0f4GQQGq5yDo3Iw0hqB9adObaq
	iE7c+3VR2i8TjOXWWPrQHcjrX3Fy+HCgrfT5tL14oms6Xn8x+n0ucqhxJQRYF0sB3XK/xm
	625dlptkt7IUL3BB2YtI4Umv3+j2CNv0xk+4Wf+WT0UhxZrzP+J6gS3iwBdJVXLz7ajng3
	wYk/roDdFG+QYvfyaoCF5xqtsHF5Zh+VgQRdSENaCDrRQ1CZnav0ZaJPfRvHFohxCdZ/A3
	rXnfJWgDvMJPI6km4sHP0l8unB/kVK1lScB2IgJbm6QesRPRPMLUryfmeCVL6g==
Date: Fri, 15 Mar 2024 22:09:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Clayton Craft" <clayton@craftyguy.net>
Message-ID: <d000c1684c8fa1bf05cd239353ef6e65038d8ca3@craftyguy.net>
TLS-Required: No
Subject: Re: [PATCH] wiphy: include libgen.h to fix implicit def. with musl
 libc
To: "Denis Kenzior" <denkenz@gmail.com>, "Marcel Holtmann"
 <marcel@holtmann.org>
Cc: iwd@lists.linux.dev
In-Reply-To: <8ce688a8-8cc4-4651-a0e5-ca20f86c8888@gmail.com>
References: <20240212184747.30422-1-clayton@craftyguy.net>
 <8b02ff06-9c2b-4503-8fb8-9784c2628394@gmail.com>
 <152B8E7F-C6D0-4827-AC38-25454FD6BAF7@holtmann.org>
 <f9970105-c1c7-484b-8e13-5ca5f5bae901@gmail.com>
 <34797D3A-D630-4D71-B4E8-BD29E9BB759C@holtmann.org>
 <b1b66222-6594-4775-94ed-2f17810029b1@gmail.com>
 <BC62FEA8-DA18-4084-A5B6-A96C82AE799B@holtmann.org>
 <a64273d2-e585-4e48-a35a-38384b79202c@gmail.com>
 <440488C8-0481-4A8F-BF68-A7F97FAADC8C@holtmann.org>
 <20240314153055.GB8925@craftyguy.net>
 <8ce688a8-8cc4-4651-a0e5-ca20f86c8888@gmail.com>
X-Migadu-Flow: FLOW_OUT

March 15, 2024 at 6:49 AM, "Denis Kenzior" <denkenz@gmail.com> wrote:


> Should already be taken care of by ba5a6df2d170 ("wiphy: Remove basenam=
e() use"). See [1]. Part of iwd 2.15 release.

Oh no, I'm sorry for missing this! Thanks for fixing it :)

-Clayton
