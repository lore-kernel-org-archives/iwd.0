Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67F62C3757
	for <iwd@lists.linux.dev>; Mon,  4 May 2026 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777877105; cv=none; b=fiEiPl+2WG8WtF7Vzpvss6xJbegFXX61UciLeq8BJe5gCuXCPmWzZC5D2Rlgbyew/ZYpl15XpYtIOjoddg+adhaTouqv0KQ/e0/EA/sovZEUg6Fz9sVBbT+Q3bckZCa4LJs/3ZeZQP72+PvsjLYWHlq0/wRkuPZId4k85hmVmEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777877105; c=relaxed/simple;
	bh=GcSGGqP6V1jmYg4gECCJk2Kfg0QcCDiEZx5H+wEc7IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTrI6Dv/h+p+5mDZ+NP1SzREIjSB5xmtSUR8RE15bXaEf1eBwQIuLAY5MnaJPi9EeU20ogmRzAa6+DbBbPfaOX+Tf5KTiGwCEKhoWs/d14xiUXQKQiERsXYcK4a2mpgaJoJRs2RGnvtjX8vHX9QRxMRQSYnd5VRQPsza7gOCiGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsCoXrtt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsCoXrtt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E38FC2BCB8;
	Mon,  4 May 2026 06:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777877105;
	bh=GcSGGqP6V1jmYg4gECCJk2Kfg0QcCDiEZx5H+wEc7IE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsCoXrttsPit6HgPOtU7iRbzellEM+2VlWUSQ5NydY+4M/WTAMUdgRRhxMhUuP2/U
	 bHjNlueA/hBk9QZra54g4CfT4LJ+YJppBUVFHYUWmzH1YoRPz0tGCp0fxKWyD7xDZA
	 8L2ff37LYNQwvNetSESCbOpavjtezy5Decjwmb5N18zCZep2kKGLZ+d1h4ig+XRmlL
	 iB8ZlvNS95X3PUel9tnOEVq3qEOFuIiE9x7v5M/ZNga92QGdRFeQpuN2poyot5lox4
	 QZ0/B0bjMgoCgdoNASx/fujPma/BBR0FgLBbTiip2VbtteAM/SfD+YOTpked5y1Npr
	 l/KxWr47lMTvg==
Date: Sun, 3 May 2026 23:43:46 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Milan Broz <gmazyland@gmail.com>, oss-security@lists.openwall.com,
	Jan Schaumann <jschauma@netmeister.org>, iwd@lists.linux.dev
Subject: Re: [oss-security] CVE-2026-31431: CopyFail: linux local privilege
 scalation
Message-ID: <20260504064346.GA112568@sol>
References: <afJorKIje4O6dXbH@netmeister.org>
 <d6111caa-db61-498a-92cb-ea7a0aa0a5e2@ehuk.net>
 <87se8dgicq.fsf@gentoo.org>
 <afL-QhLfEKqHZqka@eldamar.lan>
 <20260430071917.GB54208@sol>
 <177abb5d-8ba9-4bb9-8b23-9fbc868ed3cd@gmail.com>
 <20260501180028.GA2260@sol>
 <19837ef5-e5b6-45f4-8336-3ce07423dfb1@gmail.com>
 <021503ca-8a9b-4f9d-8b8e-81661572a018@gmail.com>
 <16a713ee-4cf3-4f40-a532-8a937eaffd21@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16a713ee-4cf3-4f40-a532-8a937eaffd21@gmail.com>

On Mon, May 04, 2026 at 02:13:01AM -0400, Demi Marie Obenour wrote:
> > - It is used for benchmarking, where we actually need kernel crypto.
> > 
> > As it will be used in real dm-crypt mapping later, benchmarking
> > userspace lib just does not make sense.
> > (Requiring CAP_SYS_ADMIN here is not such a big issue, and it is
> > a very rough test - but useful for relative comparison, not for the
> > real numbers.)
> 
> Would an API to ask the kernel to benchmark its own algorithms work
> for this?  That would be a more accurate benchmark as it removes
> syscall overhead.

For what it's worth, I've always been frustrated by
'cryptsetup benchmark' and the numbers that people report with it
because they underestimate the fast algorithms so significantly.

For example, on my desktop (if I enable AF_ALG so that it works) it
reports 15585 MiB/s for AES-256-XTS encryption.

Yet, a userspace port of the kernel's VAES+AVX512 optimized AES-256-XTS
assembly code runs at 33600 MiB/s: over twice as fast.

(Yes, encryption is that fast now on the newer AMD processors.)

So in this case most of the time is spent in AF_ALG overhead, not the
actual algorithm that the benchmark is supposed to be measuring.

(And this is yet another example of why going through AF_ALG instead of
just calling a userspace crypto library isn't very efficient...)

I know the cryptsetup folks consider this tolerable since 'cryptsetup
benchmark' is meant to be a rough estimate anyway.  But I think it
clearly shows that AF_ALG has never been all that great for the
"benchmarking the kernel's crypto code" use case, either.

In the case of benchmarking done during kernel development, we've
actually already been solving that in a different way: adding KUnit
tests with benchmarks included.

But for benchmarking by end users, yes, I suppose if really needed it
could be done using a new UAPI.  It would just provide the speed of each
algorithm and nothing else.

- Eric
