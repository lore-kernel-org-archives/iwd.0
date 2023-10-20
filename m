Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC93F1DDE0
	for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kna75kQn"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6cd0963c61cso612734a34.0
        for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697816135; x=1698420935; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pt1Yz8L+SqVcGIcI59k/6YjtZOWkYD4EIFantvrrEvs=;
        b=Kna75kQn7mtCMMh3o7UrxZRsJzijAB6ZXvvjChJccXhImkhLT2i1oYWQybC7lNeBK5
         Ql7QFiIbDzFSFjqjtWKWDAhUFSo3zUUqofrCxNVfG2m8i+ZCmca6/BH1iMd91QMGkqt1
         mMhEMBsxNghiBFoB55UWA8l0tCkjE34P64f/JQd6UHB8YYesvEMHJd3/yNuqM5mzoKoJ
         GGAHe1QP0byGLdBPiLFLbon4dXcck+CF301hVZk/sCo58nuzb65t8F3yN+mjc+cxmOkc
         gS46OpzR4pW6FxHAv1whNQtAhvpoWLsS0T/Z+HMetrxP1FO2i+9IPABRXslsv3BkGS3C
         hkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697816135; x=1698420935;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pt1Yz8L+SqVcGIcI59k/6YjtZOWkYD4EIFantvrrEvs=;
        b=J9LCSvjclp92tohzLniuzCc5vl+2q66PGbwK9eRkQ1psgm0Vk7Q5UwhoenNwoYpecE
         wyUhn485nqdooGESylYr/5v0RIRBpwpzJmmtCfil8r28ab0paePN10ucUFDWeDVS3DwV
         ZB7MgAMbqgashtNTaf28D8y3/VmyObKPMtEui5lldWJNPYQCEApLDxdBLfF7WcPF5Jqs
         7mnWhGf9ryU4GMAT+YjPn/io6wpm04yHow87mz/mgT8RffIdQgwIcZiNrhvPv04DCMRk
         eqM2ECjbv1dp0o3WkxsL8Ljpn1hjDNNg7HF/kFUlIrflzOoSi/LowxtUIjEcOylg4Ynh
         M93g==
X-Gm-Message-State: AOJu0YyKFIy685t3BR/k2Wp5S3jh0pZrCSmWradwEEYMm5YMB2ND/s5W
	DnMLzpoOYWTVTJi6jNtIHfMFAh61tQE=
X-Google-Smtp-Source: AGHT+IE0+4aXVvhRYSPoYADrJkP/sromGH+zctih/fCPXDRDGUz14hpVo/UNvxvtFUCVtale0TrziA==
X-Received: by 2002:a05:6871:b405:b0:1e9:9f9b:eb76 with SMTP id br5-20020a056871b40500b001e99f9beb76mr1705648oac.14.1697816135753;
        Fri, 20 Oct 2023 08:35:35 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id j2-20020a056870530200b001e9b02b00e9sm409483oan.22.2023.10.20.08.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 08:35:35 -0700 (PDT)
Message-ID: <d5caec7d-df86-45bf-b202-e71b865bb70a@gmail.com>
Date: Fri, 20 Oct 2023 10:35:34 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] station: reload settings in 'netconfig_after_roam' case
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231020135555.139910-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231020135555.139910-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/20/23 08:55, James Prestwood wrote:
> If netconfig is canceled before completion (when roaming) the
> settings are freed and never loaded again once netconfig is started
> post-roam. Now after a roam make sure to re-load the settings and
> start netconfig.
> ---
>   src/station.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)

Applied, thanks.

Regards,
-Denis

