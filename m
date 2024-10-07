Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02CC132111
	for <iwd@lists.linux.dev>; Mon,  7 Oct 2024 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325661; cv=none; b=YU+WSmyMURU9dM2JdtB+/kb8bopLwaHHwWO/yZKxhJ3sm8phEImHE/JDMSUm8eh7TndrrJxsX4wX9ALVEUY4ZJZEXpIJUkyF7o5npj4BW2TS4v02bGKwviv0THQ3UMnFX9Mdvc70TVss6at296EC00F7Q3HAthv2KsU7jsOig0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325661; c=relaxed/simple;
	bh=3YTS2qynolSlcBkdxEBiV2zqzXd1IoM9SsjTRIGPfTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u1KuVDeos6W5pEFTruCWlEoXB7X8AuC2rvE3LjauD5HSzX9+odVrHPbO5NSqdAacFLHIRayVYTpDu28WfODInZSwy85fa7MOJWcRpOX7imwX+5QFk6vNqJQGmP1tsf5yRY8hSzRfigaBqq+aotjxeYe/LWeV8JVUEo8dJsnNhrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k022BT9L; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k022BT9L"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e04b7b3c6dso2393034b6e.2
        for <iwd@lists.linux.dev>; Mon, 07 Oct 2024 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728325659; x=1728930459; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7eMeF+QdEgkn/JLEt1Rh6msudkPpOtVH/RfrgtOJq7M=;
        b=k022BT9LElPen653AG7EEm4O5yxR9t+4na+vg3WhBQeUlgR3bosm41Bx5NQUBxU+wd
         eMwjGmhJdoLsEZNnUhtnIlHFt23JNn5lNoqUH5uaX2iIXrsagycjWCdf+ceyW/YgbydZ
         tum+Q5OdOjXI2aH4Up3FypBpmn0rQ93ZRrR2kruDxy8CDgYHxKEtB9u4Kfid3iI4FU9v
         ZnnfUAOhcTv8RNzqzPy0osT2RtGGJ9h9Y22lv5K9cSiP0tcTEULyWojmVcavNgU8biRG
         Gr80Nx12LZNnHCG4vs2+xYzP2I3GXXE/Sg2MaCakWRjZ2cAGorKYWOxdtqFpFaA6gtNO
         nySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325659; x=1728930459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eMeF+QdEgkn/JLEt1Rh6msudkPpOtVH/RfrgtOJq7M=;
        b=hgwCWWY9FEWX0aCB5B/vcxlEQZULBaUBLejSUtUlkojL6Xl9GDt4HOGW0bHGqTEDao
         Vf82J00lIH0K1MrgQ0lXspe/ulb3njR5uCH4ED0fHjj9Yl6fc+VH4+51Dn1B1JXzfswS
         7ytYDAZpg11Y4Fjg3cwIgKa0K/X+aJqi+R6T/ZgT7L0fW0q/Qik5WTMikzQK0RIQtJva
         Jhyx5YGNgPIPDUZty8e4GrfQJ470sZzjWFBV9g3U51vOXLMdc4U5BbsBSAxi5T/2qFDx
         RUHlYKInmtWKyb/gpqUKW6fG0qQtNH9XZLB08N66ZbcM9+ZEaHPe3mduw4Qj0ZASA4ET
         UjEg==
X-Forwarded-Encrypted: i=1; AJvYcCXvJuc+hBuzYooaXiBa4Nck21te4GxxpZNxu2tizMQELre9EhHEioeC8kK+cTxkOtPTlyw=@lists.linux.dev
X-Gm-Message-State: AOJu0YwQ9+pCpdFncbu4njM8AWMTa6EbjuveDbXlh9pDIhMH1yutF5a/
	pke0Ie9v9LdXb4Qzr7jcqsWT3Lm0GxDXN04K2x6DYp4WY6fcYKUZ
X-Google-Smtp-Source: AGHT+IFyhMbwtdclxlEXQo4aIQPwCsNNgWGYXSBQefoFIfl2Sho8Gio6ZzmX1Zic0FNpM7UMRi+/vg==
X-Received: by 2002:a05:6808:210c:b0:3e3:bd9d:ae65 with SMTP id 5614622812f47-3e3c18b1a6cmr8364863b6e.43.1728325658962;
        Mon, 07 Oct 2024 11:27:38 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3e3c90023f0sm1581731b6e.6.2024.10.07.11.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 11:27:38 -0700 (PDT)
Message-ID: <2852f1d4-c857-49d8-9356-ca0cbb914792@gmail.com>
Date: Mon, 7 Oct 2024 13:27:37 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mpdu: tolerate technically illegal but harmless
 cloned IEs
To: Vivek Das Mohapatra <vivek@collabora.com>, iwd@lists.linux.dev
References: <6dbd0686-f054-4c16-bf84-0e383baefdc9@collabora.com>
 <20241005021929.2075817-1-vivek@collabora.com>
 <20241005021929.2075817-3-vivek@collabora.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241005021929.2075817-3-vivek@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vivek,

On 10/4/24 9:19 PM, Vivek Das Mohapatra wrote:
> ---
>   src/ie.h   | 17 +++++++++++++++++
>   src/mpdu.c | 10 +++++++++-
>   2 files changed, 26 insertions(+), 1 deletion(-)
> 

<snip>

> @@ -398,9 +398,17 @@ static bool validate_mgmt_ies(const uint8_t *ies, size_t ies_len,
>   
>   			memcpy(&clone, &iter, sizeof(clone));
>   
> +			/*
> +			 * Some APs send completely identical duplicate IEs:
> +			 * Since these are harmless (and ignored by us) we're
> +			 * going to allow them here for interoperability.
> +			 */
>   			while (ie_tlv_iter_next(&clone)) {
> -				if (ie_tlv_iter_get_tag(&clone) != tag)
> +				if (ie_tlv_iter_get_tag(&clone) != tag) {
>   					continue;
> +				} else if (ie_tlv_iter_data_eq(&iter, &clone)) {
> +					continue;
> +				}

No need for {}.  I took these out and applied.  Thanks.

Regards,
-Denis
