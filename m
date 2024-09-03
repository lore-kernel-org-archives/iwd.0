Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF4FF9DF
	for <iwd@lists.linux.dev>; Tue,  3 Sep 2024 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386696; cv=none; b=d9gBdC5GrqzZTKQaFlsQr1pk3Emvp02Y2em1qXH5J09K6W7tvdTjo7Hx+Gm2kxHwn/FkIMmLVyP76xPqXipM5Kltnl9yia/ULaGnkjo0i4+l6S/z2WzxzW5Va2najR7XSNIMyFqe+MKDzZsgj4PL9dmYjUGiPBPk6msVAfgxiUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386696; c=relaxed/simple;
	bh=VuU40x/TdyVbhMVTYMWj4Do4JahkvgVeVq5Qe6PuapQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NoYhnZPrpu949Ac+i23kOX9+omhwSkdyyIEHzdHCUStS4530LiXQyDFq9EjrW34FUOPqvmXX8ecGTTUCsGx53MJUDl17krJvoFrpKMRrL1C8xiPfLhYAKfh5Z4YQcaw4hEkOt1b51fDXn+CCY67qTwg4iJqdv+udkGtv2xW26FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXAhBOS0; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXAhBOS0"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a802deeb9aso353130885a.0
        for <iwd@lists.linux.dev>; Tue, 03 Sep 2024 11:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725386694; x=1725991494; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K+9V3z19/F4jmnwEUgXDeQtZrpgW1CESO9+FJMtGlLk=;
        b=YXAhBOS0U3npXtqp5MVr4pOeFmKHvRuwro1i19ErZYbqBt2hRpXLARD0GcSDf3co9l
         hmcFSO7evDf6uzGmBIQWXq4VtSWpkcsNq2qZnaTXWzqSp7fW0rAtFXufQyIUXXgZUcVF
         j6sPgMl++bE3KZ+Xf4t8XIhc6+Ks1SInTryQnP3ANGaqmyMwEP5iB71doWGA7PqE6mTv
         t/aDAx10fLbH0NZZp9KvQrc0yISTnW4aTq8aFzy4gOLk0X+1szW+S/ge2VRPG5u8p6bu
         6XXYfaBLu6zUu2J/g2oaFk1OAzJG2cM10sans3ZqQXMwZ+XHEzjFbAmnMlWJbFSMLkxs
         +n2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725386694; x=1725991494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+9V3z19/F4jmnwEUgXDeQtZrpgW1CESO9+FJMtGlLk=;
        b=STPtR3JS5SU+nPm7TDXdRqdpfHm0jMXM19y3tasX5NjPJ3vE/2vLuceWP1/FRDqnmY
         dbH4iaU4VKo1UuDaLGAutzJHKx+R1RkSc+prxMz9nP5CF42CUgvNyqsW+ZsdXKUk0l3L
         rxZiVwx8aItZOX9XBIIKwy6IuHOnUO5+iBXTTcrgWID8Ksbjkv5dGw8fKTbV4zqtl2BG
         NSjRi6v9SXR/TthcmwAdrTev08/wtfGk4MAeAGzYQUJeD3fjvt4W8uv3jax+sL4aDYoD
         PO3uOVeVNNwYjCyT41l1OJQy+e7TQAj4Kj3PNo0edsu1x3mRsxwsphV56LcBCohb6CAy
         BVkw==
X-Gm-Message-State: AOJu0YxvZsGqHI0XfceypNHjVTOUrOJTEDtQkYeIvWe2ZBftK4XP3Rjc
	/Vpw1C0oIfsY/kXwt4pHTI7ezSS/y0wRs1DdereDjMKPHvp0HIob
X-Google-Smtp-Source: AGHT+IEUbzh14LlLdUrYLOL3VvFQ3V+wD6fQVo0rFp5KG3s6ZveEVrpQlAB49gGMkhWPV5OrJHHfYQ==
X-Received: by 2002:a05:620a:4250:b0:79e:f851:66ec with SMTP id af79cd13be357-7a8a3dc6c7cmr1542035485a.61.1725386693423;
        Tue, 03 Sep 2024 11:04:53 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d390fbsm549187585a.92.2024.09.03.11.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 11:04:52 -0700 (PDT)
Message-ID: <32229467-dd4d-4207-af4e-e537500e663b@gmail.com>
Date: Tue, 3 Sep 2024 11:04:50 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scan: fix invalid read when canceling an ongoing scan
To: Daniel Bond <danielbondno@gmail.com>
Cc: iwd@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
References: <CAO=WXSdnr7q2uJwEBvmrsfu+qpVCSTj0WVkKeRmPZi=TgTfYcw@mail.gmail.com>
 <4083bf62-20d2-46e6-bfae-c926c2acbfe9@gmail.com>
 <CAO=WXSceTK1S0WgtG5cRt1B_Liq-JLqZMAxqUsHmfLkLc45PFA@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAO=WXSceTK1S0WgtG5cRt1B_Liq-JLqZMAxqUsHmfLkLc45PFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 9/3/24 10:03 AM, Daniel Bond wrote:
> Sounds good. I'm not sure where to send it with git send-email, but
> I've attached the patch against current HEAD of iwd. If you want me to
> do something else just point me in the right direction.

You can just send it right to this list, iwd@lists.linux.dev. But Denis 
can probably take it as an attachment too, if not he'll speak up.

Thanks,

James


