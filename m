Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A251426B
	for <iwd@lists.linux.dev>; Wed,  6 Mar 2024 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709727270; cv=none; b=i2Fa4dbYsP2mw/BXDCwro6HosSyvpOzzVv+1cXZLyBTyq261poPDp3I7TH0UpydJnxROiOAtlQrR4X7CjIznWr5D5rxmxfpwaaIg2DwGgAEw71udqV9Zxv+k9foi1Rx4iYABb8Yep7KvVvUFZAQZgxOoHVG9EMCNIfZOhlYF3Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709727270; c=relaxed/simple;
	bh=1dcv2Mm08BTByce2vft/IzZQMqjc6yok4GIzk/ypsGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCmWKt7vNSTkEValaMJM1s2LXXuf4Arj65fWes9N6vYS5DF2vVi5PSDyvUK11swKzZIyOQyDi3t8JIR/jkv6ESgpuyEpEa626Ew5a7j0GTgNXH2R48ZhXZY9pCsgmdW9eqoGEgxZqYYTYWSrDheDTPOtv78rmDFb/2ug4RQjR4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiIvCCvn; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiIvCCvn"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso1240120b3a.2
        for <iwd@lists.linux.dev>; Wed, 06 Mar 2024 04:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709727268; x=1710332068; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jW9/jqtqk89tNvxoKW2xX+gflSknOxdffuCJUiZvjtw=;
        b=RiIvCCvnvs7m/Z0Vw9LCY7jOzw0vIXTrSJoV+hhuaOHqCKepi1IUA5Dxm71bj8It/j
         wn3POiU3WneEBrGkCj98vNXRTPOgiisR/vPD/99DUi9eGcAdcD1Uuwi9yu09wBVShEI8
         QA++0P2VqzoJG+MyI7HSP/MsDStrU/IfE2n3zTBAC+fS9CZillGDJuZ8zFcSyfwMOjqS
         QC2WwixzX6xomtOsCcVRh3FrbgCQsfruVhMmyv4EmqQluEGusEeNqd7rKT4yKEeP72+m
         FjHjp53+uyCrgE7C5BO4/4261S6qxcw1Av8QiLG7mkcKGLbd5Z7ZcTjc5CJwClEohEDD
         Y5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709727268; x=1710332068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jW9/jqtqk89tNvxoKW2xX+gflSknOxdffuCJUiZvjtw=;
        b=FymTHrac9wQ+LaatlCMptg0cAcbbvmcdE8yBV37SM5oHGXjQyr18DbjiKBMz18IhME
         xfzPVQtpV/6jAMpDTv5AKJ40F05tm0q047BRgfPnK3zKwoYqhUL6wKtqJQlhizoGlbPX
         Va/K6pkJ3sQ6AhFAOy1VSzv9QXpol+guNlI3vtpHK1W4Ee7P3fU5m7hvhXnyf2DvjYKZ
         c16H4Usq5yYx5a/tKk1uElHcOX9DSxcTQny2CJRzvgFUKz2Q4iJKR0ztKQkdFXUnfSWP
         4A1kdfW9aowhuFfBi/tqOoyiJNL6CuISwhNw/wnELGgl0EXckDfBwHeeC5lGqq3onRQ6
         GJ+w==
X-Gm-Message-State: AOJu0Yy8Zn2J/MR48MEIifwHf+XEAcrpD0ZAAvxfa7/6lp8PLdHljWfm
	o/bJBIM9TBTJ/NTIw94BfSB+GEHDnzpEjiz/xar3YyOcl1OkXTUK
X-Google-Smtp-Source: AGHT+IHMDoyqTGtsdMeGpHNuyoEBvaRHWeCIfTG112UZpYAW+NAMp1JaCZrQbx8odUbTOpOYCAN35w==
X-Received: by 2002:a05:6a00:4f96:b0:6e5:3b8e:bb6b with SMTP id ld22-20020a056a004f9600b006e53b8ebb6bmr16195141pfb.7.1709727268197;
        Wed, 06 Mar 2024 04:14:28 -0800 (PST)
Received: from [192.168.254.87] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id v27-20020aa799db000000b006e5a0abb167sm9987140pfi.1.2024.03.06.04.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 04:14:27 -0800 (PST)
Message-ID: <435173fa-ab58-4216-a53f-8ce66ee5b561@gmail.com>
Date: Wed, 6 Mar 2024 04:14:27 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to connect specifying the BSSID?
Content-Language: en-US
To: Kentaro Yamaguchi <kentaro.y@gmail.com>
Cc: iwd@lists.linux.dev
References: <CAKbf6axbkp5E1M8Pvm1SbPOQFtzxX8Cdwj9YjbYNy0aekHDHzw@mail.gmail.com>
 <1aebf48a-0ed4-4605-a03b-5f6e0706ed71@gmail.com>
 <CAKbf6aw-So-y=NuHTo-GqTRmjPR7pN1j8UOmHOvvRETBM-3XoA@mail.gmail.com>
 <0f64f742-4fbc-4493-9fd8-bd0afdc9f4a7@gmail.com>
 <CAKbf6aw-YXxxtPFKrQW-42jrzUW5dBMdW-RjQqf4tAr-fkdaFA@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAKbf6aw-YXxxtPFKrQW-42jrzUW5dBMdW-RjQqf4tAr-fkdaFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kentaro,

On 3/5/24 8:17 PM, Kentaro Yamaguchi wrote:
>  Hi James,
>
> The IWD log is as follows.
> I have confirmed that it is possible to connect to the same BSSID 
> using a combination of nmcli and wpa_suplicant.
>
Thanks I see whats going on. There is no network profile so iwctl is 
using an agent to ask for the passphrase. Once the passphrase is 
obtained IWD still chooses the "best" BSS to connect to. This is a test 
API after all.

You could drop a network profile into /var/lib/iwd/ then use the debug 
API and it should work.

Thanks,

James

