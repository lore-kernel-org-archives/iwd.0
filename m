Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2F42652B0
	for <iwd@lists.linux.dev>; Sat,  2 May 2026 03:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777692958; cv=none; b=hQKbTv8mf4r2SF6xKzwbMJciV9dL1tVeALy8IJtw1KNn/8r1B0WCuaelCi+l3HIH1P4L5nGI5EZ3fmIXbRnTRDU0hhLkxB8qijxB2tvjADvG0ORtU9svuUyLFdyiKN1Hy4XHFeZIX2sRBTPAYxzhbTpKbAKPcAXjTcqNMcANd40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777692958; c=relaxed/simple;
	bh=wuzaKHHAs2TCciaYI3jFGkq0gEk3KhXszQpFtWqF0W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARVMFWmBnZBIgqwPqx8G99uTDEUxKfRN923XijVXhocE/3Ba/7D1JMfcOhAdwyAG2Dow1aJApIWjpE06D6fSQl+hDTLRcBtCoCLXLTCWK/MnDzkg0/fbey5VS4/QkhpqYItc/UzQsmGkuxA71pi3HXPSmITNx8eW+A+1s4q2XYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cycwGkWO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cycwGkWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6740DC19425;
	Sat,  2 May 2026 03:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777692958;
	bh=wuzaKHHAs2TCciaYI3jFGkq0gEk3KhXszQpFtWqF0W8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cycwGkWOz3EyyV0iM5hE1CgBg5ZTar7Ko1/pwlBMZwzfaX1qAroWG0fHTRdRsJVuE
	 0Vk81uz1HmpM0fKYr7STMmq2vgoUN1yKgNvSKVPV9HKBCaM6md2COelJKf2hNtHvj7
	 I0SdtbppqjvTReKWG6uhtdbCGwJuSYX7uCKn5AycNJ0dnOEis4Wsl1/BHRTKS2OpyG
	 iMzYAUM6vk9E8+fqY9LFYLcBqXMe/LglNaH4kVDZv1J8rBGts/TTHN5PmBiYH80/q1
	 K/Loj+b3UlIZKRQ82Hno2JK2iHMVQ5HjtixGxDQ/vxjZBNPaRNGyOOJEgm9fcYriwY
	 1xnMaFUvUZx0A==
Date: Sat, 2 May 2026 03:35:56 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: oss-security@lists.openwall.com,
	Jan Schaumann <jschauma@netmeister.org>, iwd@lists.linux.dev
Subject: Re: [oss-security] CVE-2026-31431: CopyFail: linux local privilege
 scalation
Message-ID: <20260502033556.GA3872267@google.com>
References: <afJorKIje4O6dXbH@netmeister.org>
 <d6111caa-db61-498a-92cb-ea7a0aa0a5e2@ehuk.net>
 <87se8dgicq.fsf@gentoo.org>
 <afL-QhLfEKqHZqka@eldamar.lan>
 <20260430071917.GB54208@sol>
 <177abb5d-8ba9-4bb9-8b23-9fbc868ed3cd@gmail.com>
 <20260501180028.GA2260@sol>
 <19837ef5-e5b6-45f4-8336-3ce07423dfb1@gmail.com>
 <20260501201841.GA2540@quark>
 <c13dd3c5-ddc1-431e-bc7d-2de39c551f8e@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c13dd3c5-ddc1-431e-bc7d-2de39c551f8e@gmail.com>

On Fri, May 01, 2026 at 08:21:27PM -0400, Demi Marie Obenour wrote:
> I think the single biggest hardening win for AF_ALG would be to move
> to the crypto library.  The recent CVEs you mentioned mostly seem
> to relate to the crypto API, and with a hard-coded list of allowed
> algorithms there's no need to use the crypto API anymore.  I'm not
> familiar enough with kernel code to do this easily, but for anyone
> with basic knowledge of the existing code it should (hopefully) be
> straightforward.
> 
> In the meantime, only using synchronous algorithms and not using
> hardware drivers would also be a useful simplification.  The latter
> would make it especially clear that AF_ALG is deprecated, because
> its one potential advantage (being able to use hardware acceleration)
> would no longer be present.

The kernel's crypto library
(https://docs.kernel.org/crypto/libcrypto.html) does greatly simplify a
lot of kernel code that needs to use crypto algorithms.  Yes, AF_ALG
doesn't use it directly yet.  Currently AF_ALG puts all the data in
(zero-copy) scatterlists, then invokes the "traditional crypto API"
which is very complex and has full scatterlist support, asynchronous
execution support, an algorithm template system, etc.  In some cases the
crypto library is then used internally, but it's not called directly.

So the idea would be something along the lines of:

- Add an algorithm allowlist to AF_ALG.  It would include only what the
  small set of userspace programs that uses it actually needs.  Bizarre
  stuff like "authencesn" wouldn't be included.

- Change AF_ALG to make it copy any data written to an AF_ALG file
  descriptor into an internal kernel buffer.  Put the output in another
  internal kernel buffer, then copy it to userspace.  No zero-copy, and
  no scatterlists.  Both restrictions would greatly reduce the chance of
  bugs: the actual crypto algorithms would operate only on these
  internal buffers, not on pagecache data (e.g. the contents of 'su') or
  buffers that userspace can concurrently modify.  The use of simple
  virtual addresses would eliminate all the scatterlist complexity.

- AF_ALG would implement each algorithm by invoking the corresponding
  the crypto library functions
  (https://docs.kernel.org/crypto/libcrypto.html#api-documentation).  No
  asynchronous execution, no buggy hardware crypto drivers, etc.

It sounds good to me.  For people who feel like the su binary on their
system is a bit too restrictive and would like to fix that, these
changes might not be all that great for them.  But for the rest of us,
they should work rather well.

Of course, it'll also be a fair a bit of work, and unfortunately I also
expect pushback from people who (incorrectly IMO) think that AF_ALG
performance is important, even moreso than security.

Either way, the first step will be to create the algorithm allowlist,
which should happen anyway, regardless of the other changes.

(By the way, for context: I maintain the kernel's crypto library, but
not the kernel's "traditional crypto API".  The latter is where AF_ALG
and all these problems are, unfortunately.)

- Eric
