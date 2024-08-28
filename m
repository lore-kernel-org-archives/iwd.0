Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D5F16C87D
	for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846223; cv=none; b=ZByDhHf7khHoi5I8vK6wRRxj11r0eF8LyCCPonSu0zyoHQQM/Nx1UFZQPXQBPW/achlSoR2pd+zbHjYE4W6IZD4oHfgJ3OGiVblxwmxXHFuIDEZkpDjiSip1QZ2Bqby46vTvkjwnMFp2/cG2apXRUku80YwYm5xm77pB8WAL5LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846223; c=relaxed/simple;
	bh=rbC4doJhgp0S7KqqhmGtaVnvlPW/tVaRWT/70r7IcNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YNR69H475p+rSVJfNow+GSILswVtYIHhyRm7XeSL0DTdQTw0+rlgSpUIojyzRMkh9ok1fglKWzU6KQaR6Rq/ZbOqf2NkNZ4xE7yi91h28FyaWRAJyA4LMZ3yS12q1TCz0Tdkm4q6iHMoSgvaciJl/cjzHh8THnwLq7AiKjfHxeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgLER57Y; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgLER57Y"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2701a521f63so4987283fac.0
        for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 04:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724846221; x=1725451021; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ygt5xtbYb+O9vpldsSEzdeQN4d71uZa8/Xqykgio6Ig=;
        b=TgLER57YQsE+DXGB7sAr7g1lJMtYy17VNOCmtcQbaOQc2Q4Vm9WSc3eJmG1+KBJW8l
         SD6VcieBvyDzgws5ULldZwUhMMg5Lk1RVDefZZ6Dz691PflK6Oar4NdPKENlsBZdY5My
         538g752IAgCG/2Srq7XTsNJvQjOT2vxegIJv5g5RDLj+uId9T9V4tzR1nksQ30bE0BPZ
         oLfYEIy4c+bed7CwkVPoz1jRwAWPChAH3x9cux9TzJtceaJa/uxAt3EQ2skaPfevN7iD
         i4gq3NJfyH1kCFfQMhwNqjB/ou/jwWn7ylDiZBdcZzAW1zef01glLkPZ6Bq+KdbnOUbv
         utaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724846221; x=1725451021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ygt5xtbYb+O9vpldsSEzdeQN4d71uZa8/Xqykgio6Ig=;
        b=Trh2+TnNOvliVtalXPH1X6LAq8zEpQ+WTagG8baP+l8ax1MznHwmEk7aruIqPoPbAi
         GGlXym9zYj4tCUh54D6cnEymMYHMehRDXq+9q9IL93jcgg7SeH4h/R7bKVK1UUO9oSgo
         ZvGSTiWCqTLzVE8C6ULm9NBCj+tPm1E/q3awVTy33c8r4Vz7owLtQqq8l+c36admuuvr
         5NGGNNKI8j8pwps0TvNn42H3HnrTYIBS1jnyuiGjUuT9G+u66Hkl/9ZiS3iMaFWLGnVj
         jyTh3CMQmCuhURx9WP351g43G9ZGNbWdCErAFPGDXDBdGkCWnLyaXAvPNKr/XM5DmSrn
         eWdg==
X-Forwarded-Encrypted: i=1; AJvYcCWwUVzHv96xSWYzilKBqNSWNbjJ462PTKH8LT+az6gAR9jMNaW8NK44X1jkPi8LiH5dRpI=@lists.linux.dev
X-Gm-Message-State: AOJu0YzMMHKYyJaEoboBkEqWqrm2Dc9nBLfCmGJHEVBdK2vr0bJ5cw3D
	SJja6oa7WxMZyqnZl5r0oKLD/LWFfnRfyN/Ly2CZjOtUkbU18O0S
X-Google-Smtp-Source: AGHT+IHzHKAz1ZpeAxHoGdc75wRRSoO8dzGdG2GelBL4ePCb9lURubluCqlDYMjL0lGO5+mfwKno9A==
X-Received: by 2002:a05:6871:20c:b0:261:72a:1336 with SMTP id 586e51a60fabf-2777d373538mr1463891fac.50.1724846221458;
        Wed, 28 Aug 2024 04:57:01 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e09e0sm9961742b3a.105.2024.08.28.04.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 04:57:01 -0700 (PDT)
Message-ID: <6e9698e9-8dfd-4819-99d0-0a75c20c3778@gmail.com>
Date: Wed, 28 Aug 2024 04:56:58 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD CMD_SET_CQM failed: Operation not supported
To: daniel antoine <univac55@gmail.com>, iwd@lists.linux.dev
References: <CA+iibzCB-6wXch6yFu-4V9dKgz0sJRopsd7wXchccptT5hNB-A@mail.gmail.com>
 <444d59ad-9a07-4d2c-922b-e6c43b7d8cb0@gmail.com>
 <CA+iibzAq50zn7=J+XtH28T=XKbk_Ukoms-K4PYoTrRPEi0J1gg@mail.gmail.com>
 <1c8086ac-1d28-4c02-8c21-c7a37148a9f1@gmail.com>
 <CA+iibzD=UQC5sDwcoOy5_tPm=_58yp-mvV973Sq3dwJrej=89g@mail.gmail.com>
 <314a3582-0103-40e1-a7a3-274897f5950d@gmail.com>
 <CA+iibzDc=45P+U-xd6gxQBCqrEtb4ENFewFfzof91a9cU8OErA@mail.gmail.com>
 <4bcf6591-168a-446c-b6ff-b8ba5f7efedb@gmail.com>
 <CA+iibzDAZ0QSH9yXBgNd_CrOA3Z69z3yhbZMaiPjMUE8ZG8u0w@mail.gmail.com>
 <CAPv5Ue71TT7dDpe6TZQSimCztT3iQew30C7i0syZb=5JhiYCOw@mail.gmail.com>
 <CA+iibzB3j__Xe2VtpEr-5BH+kcJRM06UxcxWVmVZxHVyNMWsyg@mail.gmail.com>
 <CAPv5Ue6n1BF5E=c3u_cwcHZd+L++v4X8waqKmpW9sgQNvHVSxQ@mail.gmail.com>
 <CA+iibzCRmWL9H2smcsW31744i6AVc2Y68Juw9dEA2BV8AsKK+Q@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CA+iibzCRmWL9H2smcsW31744i6AVc2Y68Juw9dEA2BV8AsKK+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 8/28/24 3:41 AM, daniel antoine wrote:
> Hi James
>
> The last commits on netdev have made the patches for the CQM problem
> incompatible. I got the errors when I tried to compile with the
> patches
>
Yep looks like those patches never got merged, and I forgot about them. 
I'll send a rebased v4 update and we can see about getting those upstreamed.

Thanks,

James

