Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C431B830
	for <iwd@lists.linux.dev>; Fri,  1 May 2026 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777666724; cv=none; b=PyfRFODZUUYWsNA9vMdYR/ECj1oAtBPJS/3EWS0mpJ86xX5ifhdtYa82OWbqdN54HUP71fYBY1HTckT3wr7WHwi0uEgVNrIcI08p1BGq5b7IpllL773Og3VW3SmqYYYZIaw5J7CNpeUyK3hijQWvpSCPVVKgn6MwO2LyqZW8T5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777666724; c=relaxed/simple;
	bh=z5dLF6RTaqC0Y/bL9qv8btlXUpTn6qLIrA8inUG+wAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVuobTW5jq55JhGWkzwGuM1cJ4iEbImzCQBsemP21IJagWl6g6CbSyLsKicLI4po767DPOQHXj5IXJFGCjVeXYFSJknHtbqcT8ZTH2F2y1oLozqtiIouBPuH89VSqVju/OKH/3+HaLopJbSFkmutLe0zL/0ko5qV5dhbjU6IZ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jghcKBAL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jghcKBAL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D49C2BCB4;
	Fri,  1 May 2026 20:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777666724;
	bh=z5dLF6RTaqC0Y/bL9qv8btlXUpTn6qLIrA8inUG+wAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jghcKBALTHHKThRK7ud0oZVrSzREda7M/Cw15kOwqORaUJ2tKr6RbnB1bh/YtrQGR
	 Ru3FAziuxeAshC+jhHKyvoPVe+oJZDx0K3UHliykiVp5266nNX5qgcDIyWUH/qpK2L
	 WdPzGqklG1c9jA07tUr9I+Ch103Id3b0dcNWOMJ4J5mLBAgEbs7elIvXX/ijGJ44a/
	 YhiDU+3yyk2mYfHbcrkZXFDHIq1re/aoa2ZJNMZp2FtbL5uTqdP+nJJnTxJL7dwo3I
	 Z7qrUQdH4zcyckb3FELKh0uKd9Tt9khe5VhAeeGCRi8Am5AUDbXHDp8Aofz1Grn2U5
	 u1H43fsoD09Qg==
Date: Fri, 1 May 2026 13:18:41 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: oss-security@lists.openwall.com,
	Jan Schaumann <jschauma@netmeister.org>, iwd@lists.linux.dev
Subject: Re: [oss-security] CVE-2026-31431: CopyFail: linux local privilege
 scalation
Message-ID: <20260501201841.GA2540@quark>
References: <afJorKIje4O6dXbH@netmeister.org>
 <d6111caa-db61-498a-92cb-ea7a0aa0a5e2@ehuk.net>
 <87se8dgicq.fsf@gentoo.org>
 <afL-QhLfEKqHZqka@eldamar.lan>
 <20260430071917.GB54208@sol>
 <177abb5d-8ba9-4bb9-8b23-9fbc868ed3cd@gmail.com>
 <20260501180028.GA2260@sol>
 <19837ef5-e5b6-45f4-8336-3ce07423dfb1@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19837ef5-e5b6-45f4-8336-3ce07423dfb1@gmail.com>

On Fri, May 01, 2026 at 03:24:51PM -0400, Demi Marie Obenour wrote:
> On 5/1/26 14:00, Eric Biggers wrote:
> > On Fri, May 01, 2026 at 11:30:17AM -0400, Demi Marie Obenour wrote:
> >>> But I also hope this finally provides some more impetus for AF_ALG to be
> >>> deprecated and removed.  It's a massive, largely pointless attack
> >>> surface which has been causing problems, including regular CVEs, ever
> >>> since it was added to the kernel in 2010.  And of course it's gotten
> >>> even worse lately, with LLMs now being able to find the bugs.
> >>>
> >>> Userspace crypto libraries exist.  There's no need to escalate to kernel
> >>> mode just to do some math.
> >>
> >> The only reason I can think of to keep it is for embedded systems
> >> with weak CPUs and crypto accelerators that are actually worth using.
> >> However, those seem to be very rare outside of things like routers,
> >> which run specialized distros like OpenWRT.  Even when the accelerator
> >> exists and is worth using, AF_ALG is certainly not an efficient way
> >> to access it.
> >>
> >> Furthermore, an inline encryption engine in the NIC would be a much
> >> better choice for future router designs.  AF_ALG doesn't work with
> >> that at all.
> > 
> > All correct, of course.
> > 
> > The main other claimed benefit of AF_ALG (and the similar KEYCTL_PKEY_*)
> > that sometimes gets mentioned is, ironically, a security one: keys can
> > be kept out of a particular userspace processes's address space.
> > 
> > But:
> > 
> > - Different userspace processes have different address spaces too.  So
> >   it already can be, and indeed often already is, done in userspace.
> > 
> > - This security benefit is kind of besides the point when the interface
> >   has a privilege escalation bug every few months.
> > 
> > - The kernel often doesn't support the algorithm needed, or if it does,
> >   some of them just aren't as well maintained as userspace libraries
> >   like OpenSSL and BoringSSL.  For example, the kernel's RSA
> >   signing/decryption code is vulnerable to timing side-channels.
> > 
> > (I'd like to specifically call out
> > https://blog.cloudflare.com/the-linux-kernel-key-retention-service-and-why-you-should-use-it-in-your-next-application/
> > as being misleading and harmful.  It says to use the kernel for RSA
> > private key operations.  But it fails to mention the kernel's RSA
> > implementation being vulnerable to timing side-channels or the steady
> > stream of vulnerabilities in the associated UAPIs.)
> > 
> >>> On Linux systems with no programs that use AF_ALG, it can already be
> >>> disabled in the kconfig by unsetting CONFIG_CRYPTO_USER_API_*.
> >>>
> >>> But there are some holdouts like iwd (iNet wireless daemon) that are
> >>> keeping general-purpose Linux distros from being able to disable it.
> >>
> >> If AF_ALG was removed from the kernel, that would provide an incentive
> >> for someone to patch iwd to use a userspace library instead.  Or if
> >> iwd is unmaintained, it (sadly) needs to be removed from distros.
> >> (Sadly because wpa-supplicant is much less well designed.)
> > 
> > Where iwd is used, AF_ALG can't just be removed from the kernel
> > unilaterally.  People would complain that iwd is broken and invoke the
> > "no regressions" rule.  While only a few programs use it (iwd, bluez,
> > cryptsetup with certain options), they are enough for this to happen.
> > 
> > We do remove algorithms from AF_ALG occasionally, but we've been unable
> > to remove ones like MD4 (yes, that MD4) that are still used by iwd:
> > https://lore.kernel.org/linux-crypto/946591db-36aa-23db-a5c4-808546eab762@gmail.com/
> > Likewise with removing support for SHA-1 from KEYCTL_PKEY_*
> > (https://lore.kernel.org/linux-crypto/f0492c92-1015-48e3-bfce-598c7a4843d1@quicinc.com/).
> > People even post the Linus quote "we simply do not break user space".
> > 
> > Unfortunately, the developers and users of this small set of userspace
> > programs are disconnected from the extraordinary amount of time and
> > effort that the rest of the Linux community is putting in to maintain
> > these UAPIs and respond to the continuous stream of vulnerabilities.
> > 
> > To them these are simply APIs available that work.
> > 
> > This is actually one of the reasons I've been making these public posts:
> > this needs to be a community effort to deprecate these UAPIs.
> > 
> > If the developers of these userspace programs aren't taking action yet,
> > people need to volunteer to go in and fix these programs.  Again, it's
> > actually a pretty small set of programs that even uses this stuff.
> > 
> > This would be really impactful to the security of Linux.
> > 
> > A lot of the discourse around this vulnerability has focused on the
> > things that went wrong with the patching.  It did go very badly, but I
> > feel it's also missing the point a bit.  AF_ALG and KEYCTL_PKEY_*
> > actually have a continuous stream of vulnerabilities, which has only
> > accelerated in the era of LLMs.  Just in the last year there have been
> > at least 4 privilege escalations in AF_ALG, I think.  We need to fix the
> > root cause of why this is happening.
> > 
> > And I think it really can be fixed.  It's just a few programs that are
> > using these UAPIs.  Many systems already don't need them at all.
> > 
> > But people need to help.  Send patches to iwd, bluez, cryptsetup, etc.
> > that make them use userspace crypto libraries instead of AF_ALG and
> > KEYCTL_PKEY_*.  If the maintainers aren't convinced yet, then patch
> > downstream in your distro as a starting point (and disable the UAPIs in
> > your kernel).  Or help in other ways like writing blog posts that
> > promote attack surface reduction and the alternatives to these UAPIs.
> > 
> > I'd also like to explore some more incremental approaches, such as
> > making these UAPIs require CAP_SYS_ADMIN, possibly configurable by a
> > sysctl.  If anyone knows of anything important that would be broken by a
> > CAP_SYS_ADMIN requirement on AF_ALG and KEYCTL_PKEY_*, let me know.
> 
> Cryptsetup needs CAP_SYS_ADMIN, but iwd definitely does not, and
> presumably BlueZ should not use have it either.
> 
> Cryptsetup is a special case because there are times when it may not
> be safe to allocate memory: if I/O to the swap partition is suspended,
> and the kernel tries to page data out to it, the system may deadlock.
> So calling into arbitrary third-party libraries might not be the best
> idea.  Thankfully, Nettle should meet all of cryptsetup's requirements.

Cryptsetup only uses AF_ALG for certain operations like keyslot
encryption, and only in certain cases: Cryptsetup's default settings
work fine with all CONFIG_CRYPTO_USER_API_* options disabled in the
kernel.  The actual I/O to/from encrypted partitions is handled by
dm-crypt in the kernel and has nothing to do with AF_ALG.

Cryptsetup even already supports userspace crypto libraries as well.  It
seems there are just some gaps in how it's using them.  For example for
AES-GCM it seems to just go directly to AF_ALG, despite the cryptsetup
binary already being linked to OpenSSL, which means a complete userspace
implementation of AES-GCM is already present in its address space!

> > I think there should also be an allowlist of algorithms, and the splice
> > support should be removed.  (Interestingly, there's precedent for
> > removing splice support from AF_ALG: it was already removed from the 6.1
> > LTS kernel last year, seemingly accidentally.  That's why the copy.fail
> > exploit didn't work on 6.1 but did work on other versions.)
> > 
> > - Eric
> 
> Would an allowlist and removing splice support allow migrating to
> the crypto library code?  I looked at the list of CVEs you provided,
> and I think it would prevent most of the recent ones.  The crypto
> library is (as you pointed out) so much easier to use.

I'm hoping that at least some of these ideas for attack surface
reduction (requiring CAP_SYS_ADMIN, allowlisting the algorithms,
removing splice support) can be implemented in parallel without waiting
for every userspace program to stop using these UAPIs.  Full removal
needs to be the goal, though.

> Also CCing the iwd mailing list.  iwd uses the kernel crypto APIs
> wherever possible, which is a serious problem.  However, it already
> needs to perform cryptography in userspace because of ECC.
> 
> Nettle provides trivial no-allocation cryptographic APIs.  Nettle's
> licensing (LGPLv3+ or GPLv2+) might prevent this, though.  OpenSSL has
> a horrible API, but AWS-LC has a much better one.  It also implements
> TLS, which would might allow iwd to get rid of its built-in TLS code
> for EAP-TLS.

It's unfortunate that the situation with userspace crypto libraries is
fragmented, with the de facto standard one (OpenSSL) not being all that
great.  But that's no excuse to say "put it all in the kernel".  Even
using OpenSSL would still be much better.

- Eric
