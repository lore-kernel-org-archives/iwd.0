Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D112384D24
	for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713208044; cv=none; b=cda711rCmSu+989IFnpZogwhMJyCcpwtRl/C3R30XoL+lVF7RuHSVlSZfgqrjbAwMzLdpfgZSfXn2bIzhSane+emj4QDSMxoiPthyL5JzU8sIepMZfTUESDq7LL9sYk4KXuXCbONOmTn/BmIE6ZA064bqHZ8ZEoIEI1ILUCh0bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713208044; c=relaxed/simple;
	bh=1sdnLNnp6W2FG1NOJhsJJjhfIyfnMnWRhOHDdw9Xb64=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T0WRIk6J9MXVKvSKun6nsBq52hBbqgBdZDlCvm0shZ1doYzF5umunjwPMzJK6KNVTOeXr08H0GuntFSnsNA5rlClYcRJCMSKExhCQzyED8ocYPjuRFUTpCPrPmwJVbk9TOkSzTQIPj2kI0L8Tom//yrkypkw8C06xjwNRUbaWrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzdHxPOB; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzdHxPOB"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c397193878so2179508b6e.3
        for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 12:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713208042; x=1713812842; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mT4Os0u8UbdcrQFmc6iaZlnGc/tMwAYNe3El3dVP+4=;
        b=TzdHxPOBIYmtOIEaVNk4hVyCVx1PqsSEMq+Z0s0iFMrNSSMOQRQdQjj8DT9ZAxTVTZ
         ERy3dDMQvkcfQBxqDH7TbYaGr59IAXfcjH93c9X1yumFZzxdPMW3FfX+LW7SgkPk5aM8
         n5sqnhS8L2bHj/XSheI0G1cA1Mp+Q8gxss/lusPI+VVcchQ9lAqMfVN0r2kEw8wqlsSx
         cuVROmhCIrjpNZBYVORi1hsLxQgXfQV4rLcdHIV5dQ+fh9G30MW+px1qH/GlSJSANeGy
         D6djdaEYgRgKtJUEZkJYH1RWRb0GMPNw/1WkH0n312bz+ysnTdvavh0e3C3vdV1Qgd31
         MfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713208042; x=1713812842;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mT4Os0u8UbdcrQFmc6iaZlnGc/tMwAYNe3El3dVP+4=;
        b=eA4NSnlNYP1X+WZcIdXaAH9qMh9M5CaKt8X9AFh4/qe+iiCRt/Gm4VuHC02NNpXSsR
         5Ubc2OpbVNGtH9vVxOASWSR4WJEDowB1L2n8I4nHTG3nI0TVvFF0y71nK95foi0ehYyq
         HQVvT9MYY2nMwkcCuAJZgHPmRBDnqqr4phD/FIu1dQjDMQczlciJ3Ffyo3HfGlaXOgb8
         GAtNWOCkTiBK2TcyHq2oLuTilfKOHVnZh/hsEwEBLY9Lzx1rZS+sRAyONTSO4YCey8Hl
         Ewg52b951mHYtJyg2UCKEEtcfzkiP1mcBZGHWEsjx5WmbNi/A/kaDWfE45NhagrqKUGB
         b4sw==
X-Forwarded-Encrypted: i=1; AJvYcCWLwpWhbXITvC5kQ6xxqdjWyrnNi8SnlePdWXKi3aaw9iYO7w8wxSuh8CfieLYQG3pn/hPVvhAcbc/P4IaIH8V9a1f3
X-Gm-Message-State: AOJu0Yxx3gYy8Bj+GpWWldqkIIz3pdU3Mys1KxC4yn3by6NMoPO6ITJm
	2qtFLsBqmaxPtQWJnxQL0Nkd7H6R2HDkJK0MVFVRMGhPSyGkJNB4
X-Google-Smtp-Source: AGHT+IF8Bo2DcK0m0spgFpIAGUNr9iaWVhvI4AZipQX2JiBVFs0x1CjGsvQGDqsocqWIHz5Iq0B58Q==
X-Received: by 2002:a05:6808:2803:b0:3c5:f302:e7d8 with SMTP id et3-20020a056808280300b003c5f302e7d8mr11315291oib.48.1713208041993;
        Mon, 15 Apr 2024 12:07:21 -0700 (PDT)
Received: from [192.168.1.22] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 22-20020aca1016000000b003c5f3c1895esm1703863oiq.49.2024.04.15.12.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 12:07:21 -0700 (PDT)
Message-ID: <819893af-b563-44c5-b542-b16a287e520b@gmail.com>
Date: Mon, 15 Apr 2024 14:07:20 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] band: return -ENOTSUP when RSSI is too low for rate
 estimation
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240415151130.40389-1-prestwoj@gmail.com>
 <873738bd-0761-4b0a-bbcb-cf76ea8f66e9@gmail.com>
 <8e9b5eaf-6ac2-433d-9c49-5f1fc3912924@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <8e9b5eaf-6ac2-433d-9c49-5f1fc3912924@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> 
> Seemed better to do this than checking for 2 return codes. And IMO "Not 
> Supported" actually describes the situation better than "Network is unreachable".

Well, it is supported, just not reachable ;)

> 
> But I don't have a strong preference either way, if you prefer checking both we 
> can do that too.

I rather we check both, since unit tests in particular would probably use the 
extra information.

>> Hmm, this set is failing CI for some reason?
> Ah, good catch CI :) its because test-band was expecting -EBADMSG when all MCS' 
> were unsupported. Really this is a valid IE so we shouldn't expect -EBADMSG 
> there but we do. I'll have to change this, or check for -ENETUNREACH if we go 
> back to that.

Heh :)

Regards,
-Denis
