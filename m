Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D3A1F4184
	for <iwd@lists.linux.dev>; Wed, 28 May 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452101; cv=none; b=e3uk4IaHXbZrPpt4zPyYkeQisrPl00fSfXVJvKod47R+uTtN0Wl4ABIjpv4Yo9CZd2WwvixEYi91zhBvbGn6lCoQ3XYlDNJAzuG8pDDlUGRpa5kC9WypYnzD+wvtoi6GO5d+TGBBCYEDdmlMMQILl+ih+L1glFsFXGyax7C69lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452101; c=relaxed/simple;
	bh=jLqyhqMXyJ4DVJnwoW/odnYbnr7gsSobNxX0oRna4Oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gTZf7tAGwc7W/RXaqu6BM6XS1y3KMwiW2tE/R//puO04ycIAIASj5D2YaGncDCdWlzhu5B4InZktFdWNmHCF2CxVcOZPyF9cg1bINstAVNdBeC5/bFoHhBHQHBmkibDbUBRYSLpvnH3CDNNI4pjkWDmqSBpSfYDFqj+nzbeSXB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHByErW/; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHByErW/"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2e8ec65078eso38613fac.0
        for <iwd@lists.linux.dev>; Wed, 28 May 2025 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748452099; x=1749056899; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x1FrLNWHMFjDQwD4k2TGQTSPBIRTw5YHr/ZXaOM6gLE=;
        b=PHByErW/XnMYbZiGCmV8UecVPVRg1f6aA/oPJnwLGIFdA9Cm9L20OkmA5Imx5gbZW4
         /YIKpxBGQtAPmLwh8vJRvM9SxTdIUiQk98Yg+qBikLlMI76ltpJmDhT/2pzlLSdJaIL4
         uzrs3upAzrdWpgNTHWBZUnVS2173gMBK7SftDQhofYct5CQbaPoDKhxwu+dhDp4ZNibk
         9cCjPs/XKQDDmsWSqTFkLweNNl8Y+XQsQkiRuAXmTBujSs255yIbzzHNfg0unAcva5O7
         al8HBEAg6V/tFqHlUPt7XJTmC1PdL4pgkLwTJ5My+BxYot9IdJE1ntlMfwMrASQbCiKv
         CBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748452099; x=1749056899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1FrLNWHMFjDQwD4k2TGQTSPBIRTw5YHr/ZXaOM6gLE=;
        b=q5i7dPM+E3Cv2FXjgs5Iw7JoP1D+BQoNQfQyXsC5x1yynvwJczPDH2FyaPETBe9ayU
         cvkjScOMr/eYm7RSrl1sEjKFGvMSW4O7CpT+VLs0vuLzKxlapnfNi2WbV6771hEKHOXb
         fi6YtAGvhtwumQcF/jSvaUj8WzXT1jb1QbsUeuVhXrOgOgfOSIThYprAzjxefRZMCL2Z
         uVzk9AJaa2sD74AsPWTr84/ORjIoO9nKIDlJHzCUzYo936ViU61DkUsKxJhNkoicw3um
         FCjKWGuKSoAhn5AcA7gTpGwGF0L2JsVQ6OanJDW1mnHgeMqSI4bericC5KDhQRVDokRv
         OnEg==
X-Forwarded-Encrypted: i=1; AJvYcCVIbYlcTQbuaJQhHSJHZUT8T8P0LFZWkwXz8IJmlkjANs4W408HQIhffySWNuu1IdEADVU=@lists.linux.dev
X-Gm-Message-State: AOJu0YwdwZ3w4Uz/MkKCK6sW9H7FlRu3hEFNIShzY6gXrb3xYDrB/TKR
	Tg/vJCHtqUXb1X7DkoYyxJnQxd5u5v7Ra6//wyduaoE1C+bh9UY2UI2p
X-Gm-Gg: ASbGncvjfjUN/nSrGJP7dL73DOs6uW3m21+32BWrdxUqznWBrxuesGNUQ+iXI07MOvd
	rYOa7dLd3qz1Iwij5f6mT/AWDgU1/0yFg0QAJpPU+7tgMugrLdzJZb6SmmikStKAACNmZ1iqIU+
	rHkKqFCFQHCnhvdFgcAtCeAvqVXBxBtPCmf1IZFhKbswKP1WKMzDDGT429Sak0JHp7ZEEVQ/28z
	62lYUlTDasrRhYypuErLhXyLanAt6Tp4jRPBBH93uhaxgIphZLhoMVIywNJXiaE4z10DdX3ZTqJ
	buWGwKs41nh5hfY35a2b63b1Jnk1yHhH27ahopIbmCLr9qcGwO5xA2SxcgCIDkPNdy8+slCLezf
	nZ7fXgiNCKc2D1rhK
X-Google-Smtp-Source: AGHT+IFk2Cs86aX1LhRkpXXEzzCli3hRFwJi0WDThZgra10msTfX4oPIuINB8w233Jqa+4ulBSOhWA==
X-Received: by 2002:a05:6870:e993:b0:2b8:f595:2374 with SMTP id 586e51a60fabf-2e862107613mr9919270fac.36.1748452098596;
        Wed, 28 May 2025 10:08:18 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2e8e1ad3347sm302612fac.42.2025.05.28.10.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 10:08:18 -0700 (PDT)
Message-ID: <362088f5-a4d5-4acd-9538-00ab62115a1a@gmail.com>
Date: Wed, 28 May 2025 12:08:16 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nl80211cmd: add NL80211_CMD_ASSOC_COMEBACK
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250522184152.29950-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250522184152.29950-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 5/22/25 1:41 PM, James Prestwood wrote:
> ---
>   src/nl80211cmd.c | 1 +
>   1 file changed, 1 insertion(+)
> 

All applied, thanks.

Regards,
-Denis
