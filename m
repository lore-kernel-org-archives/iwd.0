Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D3116D9C2
	for <iwd@lists.linux.dev>; Thu,  5 Jun 2025 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749135662; cv=none; b=O+MN1f5PUEqyvpwSOTbd/qFmkjY+nxcw5zKYTUYB1YcXUKi4YGv2aByzeFhAhBHQPoWEwNoMzF0P2vAjlkP+wAfeKs7JZeR+jPVikX53t9dY/1HgU/1Q51X+5ypHrBX3zRE2TGmkWnt2mPzZmrLEScLICrXBEkQdjRPBbdHdLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749135662; c=relaxed/simple;
	bh=f2XZupZ+09IRY//GK9igt+yR8Mw7SEDtOvrrzu2XG3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TMeds3FAKIiPa6vtrbw53sInTn2+PG4gk959di2DMXKkd8SV1H8KoM2TIaOEXEC2+AY2WPnHIj5oJYtDgUO/WJ2xrzDUwrY4q5WmNjyR2+qrAVIPLsgHJeiOEjQNeo3EEZk025cqZHC21dGJMKc9E6TssyhguVtt5kyNqfPxK4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWtzHelE; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWtzHelE"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-403407e998eso752988b6e.0
        for <iwd@lists.linux.dev>; Thu, 05 Jun 2025 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749135660; x=1749740460; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EXPvHkQSWGodQ4SZcFPqTjgRpUIJMcjopKK5VbRbKRg=;
        b=bWtzHelEY3IFbW6tP6Oip26xSVluHCwiFvZFQOZV7fKH6DLesx7bh1wwdQWW57quMV
         xI21YTDNQiw6ZOmgzjrSZR8e6r+jWjW5ryG7dBD6BJteyMYTnPtA5psi13DkDSr9OoOy
         envLT5XcZiSum1HiGjRAivUqKO9lIu5s0iYr7Ul1S7dq4IR43oeghkCJuCMwtvs/z3pp
         XiX7nlMQ9zm9i++SFA0CPpu/+fIns6xk2CHih1+CA2Iy+447kIIe/8uybddXRw8tpxIv
         kuGAgy8w7elKpB+Eog/l0pbs2tVVygZOKya5Hv6RrG3jwLroi44PUY9NpzeEevnoLiOZ
         hgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749135660; x=1749740460;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXPvHkQSWGodQ4SZcFPqTjgRpUIJMcjopKK5VbRbKRg=;
        b=Sl5Y41JYiAEj7a7+qchRRKTmgf4R+3Z4dv4I3/QanSqM4ueD2+J/sn35qzgAcqdDAg
         G1NS0ymkqnQhjIWXA0q+P+25MKhdMy3+gG0wbs3uoXnpEXlodAStYIcySqY5+45XRaYV
         HPa2Cl3K+vS1PE6NDTF64Tv4B15lrXHE/74Wu9HVejTHEe3DHfxDEdJq5VU82nopiIl0
         qri7NquFOhX4XAI4OII7y2n9+Zyyw7rJCdVRRsB/P57f/Jn9QVsTvJmkwfU95eAIRJAT
         yfSXXH/Jnrb/tojyeLO8l8oFs3TjyIYC6HRr1scHQHskrlKPAH7DPZupMuNIBS4CpfSg
         DpGg==
X-Forwarded-Encrypted: i=1; AJvYcCUaFuXDc3+NSBz0mbSjtcovVq8QRM8kzCVaqHGHSEkn+/y0i0zB0/5zsYNUAqPx3/MVgsY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxmt9lyCnfnd0bzkfLgKhJRDDhdiAILfNclR3UgZybbk/OXeY9R
	oINT4aftqlAP7oBEup1NtixGRGfhXQb+YmKRLT9lrMxZvubwGPHO3Ctav20qFg==
X-Gm-Gg: ASbGncsqWQ+n8j/URVuslIA0ysvB14isC3IxPWkMF0KiHbY1KWCzQb2GCQHIn2nX1+6
	+E1tTaGZOyMUA1GtcZDrw198rtCXXEzd8Cxdx7LJUwSvPppQ3DwBbjwPNYcAOuD2GTpp3b7L+rh
	eHWNLj7SmUcdnhrnQRZApjbjYJqgd3rFMh8r8xx71dlVeMygCzdZH+D7NEcLr3jGIOy678JdsXm
	Buaeq0uiHd08rzYKfWd9qJB/aiGGT7tzOBsa8vvM0xKJ09Krf3anAIp1I9RAwy4kjY4PslZloLa
	kcDfi+EU+IwNoFF/g2TKdYw/N7M6Ckg6gDkTy9cVgpZg3r1JoMjBZd36eq3B2MdC3T/slxzg42c
	m8YhmlmgJ9QlCAh6Q
X-Google-Smtp-Source: AGHT+IES9O/F6ZJrIicoJtVE/O3iJXZ+SYvtGChNbd+3r3CzS5rvSDX0kfBmeIGHI7Ios+RYZAwoxQ==
X-Received: by 2002:a05:6808:197:b0:3f8:4523:2697 with SMTP id 5614622812f47-40905149aeamr19356b6e.37.1749135660447;
        Thu, 05 Jun 2025 08:01:00 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-40678c1b276sm2601149b6e.13.2025.06.05.08.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 08:00:59 -0700 (PDT)
Message-ID: <731bb193-8a15-42b3-b674-e83f9a00f35c@gmail.com>
Date: Thu, 5 Jun 2025 10:00:57 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sae: check return on sae_send_commit()
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250528192759.555623-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250528192759.555623-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 5/28/25 2:27 PM, James Prestwood wrote:
> If this fails, in some cases, -EAGAIN would be returned up to netdev
> which would then assume a retry would be done automatically. This
> would not in fact happen since it was an internal SAE failure which
> would result in the connect method return to never get sent.
> 
> Now if sae_send_commit() fails, return -EPROTO which will cause
> netdev to fail the connection.
> ---
>   src/sae.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 

Applied, thanks.

Regards,
-Denis
