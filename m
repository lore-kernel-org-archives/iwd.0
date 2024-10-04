Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE64B1D5AD8
	for <iwd@lists.linux.dev>; Fri,  4 Oct 2024 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042364; cv=none; b=fIwxMPHPxhFiwdpPYvTS2dUbtaXvYNTh2uKwkC7tNOs16tbaAB1AGv0MDqs0J5Kyf/GrKpPVUQpPF4EXMsKBUv7N6eTe4Idp6u2t1zVYvChVGy/srePxr9rpvhb4vg7HPHP19p6VTA14oZeEyB7wJqOmkK66wG7pU9o9aQfGlOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042364; c=relaxed/simple;
	bh=rP5KHSxX9ebu0oav9WGDN1FEa54yB0Qb336QbYKHmvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cBbffqou2TFUeFf4qTfUQTv217ij0oPnoA461vpcx3moDfzooPK5ipaebMXMdmE6sqQsqdQ+4Kp9Qx1cFugcM4mpG5qfr0FbwgA5x4LFnXeQaH1XtZOnTdccRJL5bXbFH4ZEkm6jeajVi6xVPwCwaI8U+Cf3hy7k7/szl/rQNdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cSPT4ibx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cSPT4ibx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728042360;
	bh=rP5KHSxX9ebu0oav9WGDN1FEa54yB0Qb336QbYKHmvo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=cSPT4ibxOtobWJWlaDNRuGs4Uy3mINaWxvSoORTSSZngbDrQKCWh4AP47LPp/6DCz
	 bauMda167y6cx69U4zL9a4loK64X2nPdXojDD4r8l7yPdLYpq9uRuR+Wvr226GjcdJ
	 i6OF1SFXSURYf98kLwRIqzqpnkk+YOx7woUB9ObxIkJTzUPEjux2enuz5QCFTQy30X
	 KxcgJT5zUO1VBdkDlqtJFvbjc/9Lnf1lK8w+zTu5pwB6fVrsG+n/Yr/oq+ivIDlwT3
	 hXkxvjKhG4zHyzxQnqycxFgGpDc/JhRkRHlil+kxuNDo5Iiw/mldOcn2ph02zdK7Yx
	 E5SwT+bfgU3OQ==
Received: from [IPV6:2001:4d48:ad5d:8e00::197] (unknown [IPv6:2001:4d48:ad5d:8e00::197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vivek)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7CC5F17E1395;
	Fri,  4 Oct 2024 13:46:00 +0200 (CEST)
Message-ID: <6dbd0686-f054-4c16-bf84-0e383baefdc9@collabora.com>
Date: Fri, 4 Oct 2024 12:45:57 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Interop problem with Quantum Fiber WiFi7 pods (duplicate RSNXE
 IE)
To: Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>,
 iwd@lists.linux.dev
References: <26febdbb-1184-46be-989b-45aace86f104@collabora.com>
 <f234b143-63f6-4184-b97a-bfaa082d8cf6@gmail.com>
 <f8703c80-14fd-42b8-bf8a-d06919b0db6e@collabora.com>
 <c400002b-ce76-4cfa-b5f0-c51be00eb9cb@collabora.com>
 <a6e3a5c8-2f6a-4af4-9433-2e3a3c74c1e8@gmail.com>
 <8da83f6a-a437-4306-875f-b7276da342d6@gmail.com>
Content-Language: en-GB
From: Vivek Das Mohapatra <vivek@collabora.com>
Autocrypt: addr=vivek@collabora.com; keydata=
 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 Rdk=
Organization: Collabora
In-Reply-To: <8da83f6a-a437-4306-875f-b7276da342d6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/10/2024 03:58, Denis Kenzior wrote:
> Hi James,
[cut]
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=8f9ed66bdd4c26e619f0878cc8ef987ce27e4305
> 
> We gave up on enforcing the order a long time ago.
> 
> Vivek, if you want to submit a patch allowing duplicate IEs as long as 
> they are bit-identical (length, and contents), I think that would be 
> okay.  From what I can see our logic should be only picking up the first 
> occurrence.

I'll get started on it, thanks.

