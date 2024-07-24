Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69BF15D5C4
	for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852843; cv=none; b=EmfMaoObhXtadW9f7Z26FumEq+/fCD7HPKU5te/cqNRUKhlfwulBW7yvmDBmb+p+/RMXltCEBMqhYSBeu3d795srAN5SdcRUFcohQpuR4+QfDniOyestLttQvm2SjJbRphlb2Fe3HJGyedKCJCsfmo4d9N1UaxBwbvQiaslaaes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852843; c=relaxed/simple;
	bh=4I4w4r3+NUYjoq2eqCi2QldI2jRIka2Nkv82m1baxsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XcmtNzhRdNdF3nf7j85L4Phsih5NNZZMXhElCDRyY5C0kPr4xQrKc6pkk8N3tLFR9vmJCKqk8ntstGT+XXB3EbEcKRYowD8dEyuvifE1xWy+Y2+hMjfVf4GOsC7AjJQ8noTew38/FfIyd5bdqxYdP8tek210l4t+y0Jfd/NVr/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3MyLSBs; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3MyLSBs"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70362cb061aso85928a34.1
        for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 13:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721852840; x=1722457640; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xg4LMazAUOdTKg/385K37/cTX2xL0E68UHkBcK1Jk70=;
        b=a3MyLSBszTwdUtsOa3l0v13b0pkCl1DSzu+3IkEnkubMQ1lYVUPvUekInKbp26hT2J
         CU41RF3+bSju3GvPvwK04FXjulM/HMS+oWCKOfjoSfkyFCoG0v5IuuHZ99hVuxG7/EFq
         INBzHcOT9Ul5Wtj94mDFPUXEwNDURllBjRSCosdadr1JfqiPI8uXkzipBxP7oMdnalsR
         RycWInZuBx7mK8GY2pSw+S/j9HuUZn9c/6VdsORtjYs7vOt+VN1GmlArYhFvEhrR04Gi
         sJh/YJwOVNEtpfZwxUcH24+u38lR55dXIGAtpGPpjpkCMG/TTrpcoCQeLsJz9c/2dt1Q
         IgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721852840; x=1722457640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xg4LMazAUOdTKg/385K37/cTX2xL0E68UHkBcK1Jk70=;
        b=YlLSgZB1UZA+MAUdlfplJC1+0iHE2EdWcQ8l25ZbCfX4ULjhsYlUfluOJO/kkN6PCJ
         1MV62d39UmWqXWYoazFTSPyS974OrDm08UFPrXOpRWyXIn6muyrgpR+2owDXfc79HlDR
         6FkP1cEmwjuGZseKooeqWcYFZWcORSBD3tqZEwt3Ndcmipz2z6GAj+FujuEmDIVvHdY8
         0XQ1mOGQNS5TsBnX509pRQPgk7azQVC7XE3UL8/+x195FdIVHyr5cIrCE2A76ckPGGq+
         lEuDi7ToOpsFhv5L/5N5xm/zWk9NSfaatL7EAydux/CmHzyDI2QxDjXGA8U739V+OERL
         5tfg==
X-Forwarded-Encrypted: i=1; AJvYcCVSwwhIZsrlaA/PbudQYyocaiJMYb6Naxdc4iFB+4Q6snnl/KmmNlIQAXWMulFeG/HytNNtmZhVaqC9gkbSQr1L/6tD
X-Gm-Message-State: AOJu0YzWUJjATzoBB0yjqp6SD2swQS2jByV3viSuu0EUThYa0Yl/YtZs
	MVV6lz14W7PKl1Gi4jA14g5BoOC/c1/jf+XbdzSBUJuYYzXivTM8
X-Google-Smtp-Source: AGHT+IGFz5Z6aNi5Jv8s89mDWQkHkC2Iuo6xf6ho87F9KWoLCWwVwcbJniy506JGG2OQDLpNkj7JCA==
X-Received: by 2002:a05:6830:6181:b0:708:7dbe:61f6 with SMTP id 46e09a7af769-7092e77f036mr1315521a34.29.1721852840602;
        Wed, 24 Jul 2024 13:27:20 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-70930778280sm20611a34.64.2024.07.24.13.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 13:27:20 -0700 (PDT)
Message-ID: <e4f4df6d-9b64-4c30-954a-dda07800ad24@gmail.com>
Date: Wed, 24 Jul 2024 15:27:19 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dpp: factor out PKEX/DPP start prep into function
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240724154641.1461593-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240724154641.1461593-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/24/24 10:46 AM, James Prestwood wrote:
> In order to slightly rework the DPP state machine to handle
> automatically disconnecting (for enrollees) functions need to be
> created that isolate everything needed to start DPP/PKEX in case
> a disconnect needs to be done first.
> ---
>   src/dpp.c | 64 +++++++++++++++++++++++++++++++------------------------
>   1 file changed, 36 insertions(+), 28 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

