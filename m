Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA96E26AED
	for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaJ4da8f"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6cd0a8bc6dcso3701540a34.2
        for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 12:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699994884; x=1700599684; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Go2bOdzNF8g93eyMbo2RQwIJadnqEsTL1IWFHyVK9DU=;
        b=MaJ4da8foqRfJ7ID8x5R4ZUR81CWE1rt+4jaljBcv6GAVXoDsYWHmomxFHt8ilMoAl
         JtkYCAlzzfjdIhJpT0LpHBIKWGaY+daj7fp8bs1+K5jCtYWkI1VgPPd3ESNQwacPN4Wo
         tua42UBQ2iIkCtlzyl/OTnuGTA5CkvqKL9wmNG2PTPKVP8J0Oj/e+AWAhpSDJ9gD6c4+
         KXPhZnwW1LoH9HgAy7KRpw+TP6inOfbWeYp8kFzgk7FkvTqhsR3jBavhNWeJcp3qTAUf
         g2b7ODz+L3SJ4G+BY4JER4XYQ7FwEpidAFzkVc1P7LRGikzlC4nak/JTuEZnRkNekxFr
         s54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699994884; x=1700599684;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Go2bOdzNF8g93eyMbo2RQwIJadnqEsTL1IWFHyVK9DU=;
        b=PmfAvEYNfTmWiAbNrWHfdcttRYncRCDqfdjf2oG+Ks/P+LvqvBDLejfr+QeYlJXY1f
         rh0esOSlOPBVfz9kuO6FCbR5SMvDP1fAVVX4k3Z5xkFrWU8U40DUAC2EJHge+WCnLNUK
         +iDZtTU0y5fWL7FhX8P0cGITwKVVdKVuW8gwjoelnVYSk2OmFtuLbQuV+4uZd0TiI2HA
         keE7cGY3ARJyQ/zGlWmVEgvUWuHTCkW7e+Z3kt2OFXrLTUmsgvcNOvhXFD9h+q3SWDkB
         bOVDu+t7An6IxU11oJqdxLFyztO0AtkTZQct0/qcSWUk9JYF6cvzcDBLEJOnIP0/gKEe
         okjA==
X-Gm-Message-State: AOJu0Yz4FYvJ2pYHsSeVaH5SheTgpforHF2kGopVUv4XArq7WwTfEJqc
	lJk9F4kTKxPz4wyp636LyHGz8jkMb/g=
X-Google-Smtp-Source: AGHT+IEuQzl3TsJpnND8egJ4UuzVCvZOKzTuqflA+ZltrSsa4XANCK12YM/nk8DOuJbYzD23Cgqy7Q==
X-Received: by 2002:a05:6870:6b89:b0:1e9:919d:83ec with SMTP id ms9-20020a0568706b8900b001e9919d83ecmr15004515oab.28.1699994883703;
        Tue, 14 Nov 2023 12:48:03 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id g3-20020a056870a70300b001dd8c46ed49sm1505987oam.8.2023.11.14.12.48.02
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 12:48:03 -0800 (PST)
Message-ID: <71899ea3-c6bd-418d-a0c3-06680bb0707d@gmail.com>
Date: Tue, 14 Nov 2023 14:48:01 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] netdev: Fix obtaining reason code from deauth
 frames
Content-Language: en-US
To: iwd@lists.linux.dev
References: <20231114171455.1108856-1-denkenz@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231114171455.1108856-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/23 11:14, Denis Kenzior wrote:
> The reason code from deauthentication frame was being obtained as a
> uint8_t instead of a uint16_t.  The value was only ever used in an
> informational statement.  Since the value was in little endian, only the
> first 8 bits of the reason code were obtained.  Fix that.
> 
> Fixes: 2bebb4bdc7ee ("netdev: Handle deauth frames prior to association")
> ---
>   src/netdev.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 

All applied.

Regards,
-Denis

