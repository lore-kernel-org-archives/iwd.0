Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DE1223DFA
	for <iwd@lists.linux.dev>; Mon, 19 May 2025 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690627; cv=none; b=PeUMydAoS15TSIy/ysp9xvOinZ76HwX/++eji0t0wufu5TM2/Hp4jOWVvr1P66DzzeVC6M9Th4f/x3bP4ZmS2KV27PKIRpKMcbTKQg0AMrI8EojOvYEPrY+syUImxhVw6AX0ML8LhQF9H2IgkuQdpzl066LmDd/JyW1APVJgZrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690627; c=relaxed/simple;
	bh=y7hYIN1IjrZqpkpn6/l418a+12yicCc90mqAh2SVZI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rVPHzu98Q7cdFSdBoCySHgfFHrqMtALr2GXfx3wckxeo0EhPGR2AVhtAO0VJbCCR5GiH1KyEnasWCh5LIi1UagcdhYQSV6lnIzKzg5Y/53U69OJH22X4xxjvcd/q/1ssFy0abx1BRJk6iHmi8s9OZ2C/RCg4P7Bi3STHO+03Fbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CB4q1mc0; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CB4q1mc0"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-60402c94319so3077112eaf.1
        for <iwd@lists.linux.dev>; Mon, 19 May 2025 14:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747690625; x=1748295425; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zrvcjHAwtTI0p0kDSQ7Vz2kBH55eXO/oGD3vwpgJfI0=;
        b=CB4q1mc0XVGk2wMf23ml+eylLn/duR4HEnEPIhpqSmgVYSGeQLrarHUsyAVjW46LAM
         oMcRxgxscSnAFYKwOpFJaBOul8dlhQIZJyzJrzz8Ga/WER9hsCMZffYzasT9NfXY9wu5
         dJ5eFnEUF6zCc0/MYXo4zsLfpGcwejdhubXZ6ELdJPc8O9RvpXAtguWMChCc9DTy+CoL
         f0j3yXeM3LuiRQmSVMVy050990Jg9xrAJUVLAmNZW0LZyB5mDzUJS60XAILZ6XJ1xiSf
         R/aALkQf3rHmZZVL1+fFqWgYpDAlv3w9dBEx6IF6My8tMYKUJ28LqEG02AoTyfP5GRW0
         kHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747690625; x=1748295425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrvcjHAwtTI0p0kDSQ7Vz2kBH55eXO/oGD3vwpgJfI0=;
        b=rBZSZ+ahw1EdoYVkVK7fLPHCE4XJsQMbc6L/EKsSYWGwi7lObpHYXmSoJuDqQ16owG
         TN4czi54W6JoZWTT3aFYaEuJYhnSoIyZiDDjNfHnAEea0UvFdGmxsVpVRcLTnltOqvKu
         Wat1Xlpb2Muy8SgBYR7MnHbpi81ggyROCmR0eRssB2kg4AeH01H+J99VC5ehWov+vhgz
         EsJQPnetChjc7DYaWwW0SA8xC0u9HGI6jkF174weZQTPpbPOAgLPbvuA/e1zKKLdtaMW
         Wr0KHM+BRlBxTGcyREu10pyl2tu/C3G8VH/nY0ImUBlCGfcz44VdB8CCJtM5N1uesril
         hY+g==
X-Forwarded-Encrypted: i=1; AJvYcCULZzCJfC4Bp+ZwjrCROIXRZtQjZCZYSmoypnRNKbWFyL8e9d87tV96Nx3yGVHlbp7umz4=@lists.linux.dev
X-Gm-Message-State: AOJu0YyRE/YIX26WA1MVrrdPm3/Ihx5R7cMSnFneDYWTvGJPxCjPAon4
	B63fx+XMFhJF7e5k1kXt45Du1crG14ZF5biPH0qJqf++8r2l01bnVzpE
X-Gm-Gg: ASbGnctMW89z8hC/k3PgMFovu4/8vCTaCS/8ocZtfMckeqWSJhU6QUm+gNnYxgoCweB
	SE9I915Go6BLEF/UqJOSDgCNcZz265SVC/F9zfROvobN29H1aZpcvrt6W8Ap1pdp2Kg8Fd3iV8w
	VKKz2jJsH+1NWZ7TtM0vnPGMVLLFHwXVuQHOdChRQl42Dxrhcn/SCEeRb2LmA9jcQHF1dZ9i3Uf
	vi92XL166+Y4pkCb3KSBXVNtuWB+C5+8BG1oW7txI1f3ebU44UE26Zj633yA0uFxo2CIUlz8AXC
	ToC2w1aKhjQi66PkS8b0Tog/BObdr+PC+PEZNkIoxzPMqoRByzBiiPuW4T8E4J2Gq5+7foOiGMe
	BQaifAOiI9dhL4XJz
X-Google-Smtp-Source: AGHT+IHBGLZf35xh2xuzlf3/1lkT/twIESYzy3VigV2WAVj2iJWExql8ddkYiasfsq2j8F1Y3y8PEw==
X-Received: by 2002:a05:6820:450a:b0:606:8579:4c5e with SMTP id 006d021491bc7-609f36bc2e1mr5281535eaf.1.1747690624710;
        Mon, 19 May 2025 14:37:04 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-60a03f5bcbasm1029221eaf.19.2025.05.19.14.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 14:37:04 -0700 (PDT)
Message-ID: <b23dbecc-f0c5-495d-8f82-8947d8215923@gmail.com>
Date: Mon, 19 May 2025 16:37:02 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ap: implement pre-scanning to "unlock" frequencies
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250519143930.182695-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250519143930.182695-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 5/19/25 9:39 AM, James Prestwood wrote:
> Some drivers/hardware are more strict about limiting use of
> certain frequencies on startup until the regulatory domain has
> been set. For most cards the only way to set the regulatory domain
> is to scan and see BSS's nearby that advertise the country they
> reside in.
> 
> This is particularly important for AP mode since AP's are always
> emitting radiation from beacons and will not start until the desired
> frequency is both enabled and allows IR. To make this process
> seamless in IWD we will first check that the desired frequency is
> enabled/IR and if not issue a scan to (hopefully) get the regulatory
> domain set.
> ---
>   src/ap.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 86 insertions(+)
> 

Applied, thanks.

Regards,
-Denis
