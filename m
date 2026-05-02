Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72BA135A53
	for <iwd@lists.linux.dev>; Sat,  2 May 2026 03:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777694044; cv=none; b=ErKP1mlSX8vvB3hSGvygvvGYDkvntOcGqLTWAVzj/qHXgg/ONd3wMLSNMLw+25tdM7lR18ezL82YB/CG+oesESDfINsOmPr6+OrRBJLPVF7cQ/a8LBwegFqDWrO08HIKioYEXHhOIGndQ7TGcvSzKBhxM/QPjSvzoyuaCuewQSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777694044; c=relaxed/simple;
	bh=EsYCe9nbh2mn81XuVQebM2e02FYmqCEbGRpAG59hUYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbklxsvfmVKwhz+Nkr36r1DCtbnarc0PBV7mbdcsUFAlkVbTwfDz/G/Tmljp1ZuI0jlORxnYmZXGGgghdGE/6CMIkWYlsZ1Uc4ZYRnaBsyMBjtDI46vDxfjYOG+OrQOcIXdla+WqKpOzc5I0kZkanPWG6UO6r/pgSP58nbJ60MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFle5CY8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFle5CY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2573AC19425;
	Sat,  2 May 2026 03:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777694044;
	bh=EsYCe9nbh2mn81XuVQebM2e02FYmqCEbGRpAG59hUYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFle5CY8VXnwlWrNx30KEP/8siiDXFfW+MEZYr1FSkAIIgfizTX7qH2Wwdc3kHcrn
	 A+N8MZt/mvlJ0SQHBhgomAWw4Dy1Un4pQ+xIDAo4hO9mHwna06IZZKLBhKX2E1TNqB
	 WP/g3YyM9VKiT1Iam5Lv76MPmuEAFMhiuQTYz4z3+FwdC0tfLslQThaZ4Sh74Z2adf
	 w6hrMObAluXMUER2pezcrTY+WBu5BIvQophPV5hohS3VPpdIZGTZIv+3dnxc2mfeSu
	 TeGLPYJ2Zne42a+LRylqIHLZLbZqNWODuRtGO7FPErddKuq0slsSuiHk4w3aXDEF2u
	 59SxNS1Q+dI3A==
Date: Sat, 2 May 2026 03:54:02 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: oss-security@lists.openwall.com,
	Jan Schaumann <jschauma@netmeister.org>, iwd@lists.linux.dev
Subject: Re: [oss-security] CVE-2026-31431: CopyFail: linux local privilege
 scalation
Message-ID: <20260502035402.GB3872267@google.com>
References: <d6111caa-db61-498a-92cb-ea7a0aa0a5e2@ehuk.net>
 <87se8dgicq.fsf@gentoo.org>
 <afL-QhLfEKqHZqka@eldamar.lan>
 <20260430071917.GB54208@sol>
 <177abb5d-8ba9-4bb9-8b23-9fbc868ed3cd@gmail.com>
 <20260501180028.GA2260@sol>
 <19837ef5-e5b6-45f4-8336-3ce07423dfb1@gmail.com>
 <20260501201841.GA2540@quark>
 <c13dd3c5-ddc1-431e-bc7d-2de39c551f8e@gmail.com>
 <20260502033556.GA3872267@google.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502033556.GA3872267@google.com>

On Sat, May 02, 2026 at 03:35:58AM +0000, Eric Biggers wrote:
> So the idea would be something along the lines of:

And just to make sure no one gets the wrong impression: just because
there seem to be ways in which the attack surface of AF_ALG could/should
be reduced doesn't mean that userspace should keep using it (or even
worse, start to use it).  Fixing programs like iwd needs to proceed
concurrently, so that eventually (some years down the line) the problem
can finally be fully solved by removing AF_ALG from the kernel source.

- Eric
