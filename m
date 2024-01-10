Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD544C3C8
	for <iwd@lists.linux.dev>; Wed, 10 Jan 2024 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFg5sVbS"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5988e377264so807608eaf.3
        for <iwd@lists.linux.dev>; Wed, 10 Jan 2024 09:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704906644; x=1705511444; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vZZ1inw7s9jpN1sVUmTm38D2d2y+zk1NaYdMlKj5i58=;
        b=UFg5sVbSJIuSO9fXpkb+eotwzU8jOpB1vU82TukA/de1TzJOy8uZthl4l/gMpi6eOs
         K3PkIGbYdS7/xC7LEujhiBKulKOFRlTQB+Ei8Cmd24XmSeAh4TJWgRNjx+OnUvPn6mdg
         7PClp8ag9jTjbTdCH8nmX90VDWJjVJbq/LJbwgScxjx8H5KulI0ym/0jgzVOK7X4s3zQ
         spzapUuejRpaTP0ZJRIppZzsomQZlN+XL/tZ0HdHjynbwTc89VbniJMW6zPrk8WeiUgR
         miC63DU2qGq6Cl9u4lRe3R5v/Jnf4GFQH3pA3xowTR+idDH0C62xBQ1Xxdzw+eTn4+LG
         4sVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704906644; x=1705511444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZZ1inw7s9jpN1sVUmTm38D2d2y+zk1NaYdMlKj5i58=;
        b=DTXy5cQ9TT9QrswqemBs1uRaM0yeU397QmSIDocAcI7P9BEgQTz6mRFKWhuxLp/FXf
         L4qfBHU+VolhLFPl4cKpWXKo/0LlvACBCjfibe2p9oAROiYIxgd11At2hV2RVHPwxyf1
         lF1QNH8PJAdTGTXGKTiDytYrt5yB/gCrL6un+0GmyPbM9J+MGF4dMZndJxCEhjS8CvVx
         OYiOLAfX59dUootzkgbF4KFMBPOQyi8UX6vaVU3cYq6o0SBb5Ax8gyUf8C1YQn/qgzKf
         uXQ2D6azJ3Ub2242Lhay++jFF3ateSdGGDNH1iRI7RysC3x94Av+uZN/oM3oztpEAJA0
         QNDg==
X-Gm-Message-State: AOJu0YykNQuT53k+g/LCiPBRZeisN4Vog5lLtjDUdb/2iX3kXY5Y/NaI
	KyhM3XlkdOm2ExWq2ZU+mo5ZQj2+SnE=
X-Google-Smtp-Source: AGHT+IF/WUBqpwZbSsRwwp1xCsUOifNc5sCcXD5n/Zerfv7EJlyhTAFNeWe+Q4sISOjgCQr9EMwAqg==
X-Received: by 2002:a4a:91d9:0:b0:593:e58a:9bd1 with SMTP id e25-20020a4a91d9000000b00593e58a9bd1mr1376134ooh.12.1704906644442;
        Wed, 10 Jan 2024 09:10:44 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id f203-20020a4a58d4000000b005987aeff34bsm820942oob.1.2024.01.10.09.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 09:10:44 -0800 (PST)
Message-ID: <da2a29f9-54ad-4faf-8e9c-1fce457f68ca@gmail.com>
Date: Wed, 10 Jan 2024 11:10:43 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Log falling back from SAE to WPA2
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Fiona Klute <fiona.klute@gmx.de>, iwd@lists.linux.dev
References: <20240109095926.1541238-1-fiona.klute@gmx.de>
 <214422a4-25bc-4676-8a4a-8bf8d67c7ab9@gmail.com>
 <BD87F517-7D4C-48AA-BB73-D18C9AE6322C@holtmann.org>
 <44da90d8-88c4-4a92-9114-0ed875e86cc7@gmail.com>
 <C50971A2-BFDF-4A5B-9027-FC32462AFB88@holtmann.org>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <C50971A2-BFDF-4A5B-9027-FC32462AFB88@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

On 1/10/24 11:05, Marcel Holtmann wrote:
> Hi Denis,
> 
>>>>> I've had connections to a WPA3-Personal only network fail with no log
>>>>> message from iwd, and eventually figured out to was because the driver
>>>>> would've required using CMD_EXTERNAL_AUTH. With the added log messages
>>>>> the reason becomes obvious.
>>>>
>>>> Interesting.  Last time I checked only the quantenna driver used this feature and it wasn't very common.  If it isn't a secret, what card / driver do you have?
>>> according to Arend on an email thread with the Apple WiFi support, he hinted that Broadcom with their devices/firmware opted for the CMD_EXTERNAL_AUTH option while the Cypress/Infineon devices with their firmware (like Raspberry Pi) are using the SAE offload feature.
>>
>> Yeah I saw that as well.  I don't have any Cypress devices.  AFAIK Raspberry Pi uses brcmfmac + firmware that supports SAE authentication in CMD_CONNECT, not CMD_EXTERNAL_AUTH.  Someone who knows better please correct me.
> 
> I got the impression that Apple M1/M2/M3 Macs (or even their Intel Macs) would be using CMD_EXTERNAL_AUTH, but details are unclear. Does wpa_supplicant actually supports it?

Seems that way:

https://w1.fi/cgit/hostap/commit/?id=5ff39c1380d9dea794c5102c0b6d11d1b1e23ad0

Regards,
-Denis
