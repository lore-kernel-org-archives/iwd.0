Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7047182DF
	for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005585; cv=none; b=o6HkbGeD4qwcWGB7rekFzwnw2EU1XMw7R4z+XWyD/CF7V6R0syrl+9ixJSrURHE6isfkBbuB2DE1h4Li91KG7nBAHXJw7eXeT6nj6l8D1FIc4VB22UcRSCVT5fVVAKMt5SOf0oTz3XAaV3SCeVVgwGsAXTj6z8HSu82zQ+1TL1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005585; c=relaxed/simple;
	bh=y54IjE7mOLsbMriFf1XBhL9JgAVkjuIQw0YDzxdl/V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I48yF9nJ67laYKfcWewda37vS7JRMecDI/1S8ztl2P6thA6jmhppD7ZG+hcIWakLYoKyvcEWQVAy6pBqfrbWLy4SsEjaNnviVr92L/4XW7djc8gdhdB4u6ojmsP/OLYE1XI+r9pbW+fKyaJndwV2jljErm+omwWjkm+LChVfwaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoYU27Ui; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoYU27Ui"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-704494efa7cso630290a34.3
        for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 07:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722005583; x=1722610383; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r11Klw5GqcqWtNxpghSzIP0DXWuGuF36HxQZPShbmDY=;
        b=VoYU27Ui/pWfu7RuFqluELNsyUq+gEBcpqMuWY15+G5JNKcLv9crKJfFXhjQqQRiM8
         MSNvfQBLaMH5UX2ZvQhw1fmtC2FDV+6F5MW2dQ8+oByWY+aYIG2Ic1voKzPoXf5YR1qW
         clUwI/KvQ8kkC1vg4yLhykAoniP1MQ6H93UDv7iIyxWRQReEwoEXMilXckuABTO4PNiD
         ZmEwbRbD3tIgpzmxnylsiygVjwVKNjlhYoTBbJV1GsjWfHhMowzMiPlDahZyGJfYie3F
         W4VOqXFYuadZ933+FYH3mZsjjKNCIIhCkG8Jyq8xKMwGC6WH8rDpYOoZ7glWFptCgYC0
         TqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722005583; x=1722610383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r11Klw5GqcqWtNxpghSzIP0DXWuGuF36HxQZPShbmDY=;
        b=mFNP3EtdUdHTuEmnmvZZbe6WVsgf5ok+TLqlcmhxuH2JBCsUPjcJNCiikx34v3Hvch
         3SQGtcXxy5NlYXrJ9uoLZqb+O6glfM8pp5th9o5hw+7RkGIQDXNDwVaBwtgAY4W1liEV
         wBrfXk9HjSumvu0zUl+EIT5jbpm8t/v/+eSJ4lf3857GH3BGWJL82q87gEoraq9Zl1Pt
         GAXPBUhXewr7nvJqQ0EZhMHQWhghAtwrzrXSLOi6rhRgJnxi+mr2raxctuTQ6zGyqbSe
         +3nQyhYvbMWtWufkaD8m85BIt4tgYD0w5Od05vKeXoatnujsRVyCNAhHWfHE7ndBAS04
         aRrg==
X-Forwarded-Encrypted: i=1; AJvYcCVaB6RY41yRSXCgZ+54cm3yzWYjLbEZs3/J27XVFG34UKH7W6dtAzC79X4ah6AhSpG0yybKesXyX2Ph2kKde0Vixo3O
X-Gm-Message-State: AOJu0Yx7EXjhx45PX5F9luFQoPM3HUo79/LthQ66Y0putswHMA6nJRJr
	pcsAzRbR7ccAT7PLceQdQ+BZYsq1+tt/Z+GMt4mdDX3zjpXA62H5
X-Google-Smtp-Source: AGHT+IGDHNtg1Q2PEhuNx+TUb7Kg5DTAorwGGatH6LFOpJCQCamFUs4oEliUmZ/rOi0pMrc7HE4J9g==
X-Received: by 2002:a05:6830:7303:b0:709:185d:48b7 with SMTP id 46e09a7af769-7093222b7cbmr5772423a34.9.1722005582871;
        Fri, 26 Jul 2024 07:53:02 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-70930785d23sm766375a34.72.2024.07.26.07.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 07:53:02 -0700 (PDT)
Message-ID: <e57951fe-9729-4e74-bb59-5467db4ae71e@gmail.com>
Date: Fri, 26 Jul 2024 09:53:01 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: fix the CQM RSSI threshold attribute
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240726121808.1629079-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240726121808.1629079-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/26/24 7:18 AM, James Prestwood wrote:
> This attribute is actually an array of signed 32 bit integers and it
> was being treated as a single integer. This would work until more
> than one threshold was set, then it would fail to parse it.
> ---
>   monitor/nlmon.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)

Applied, thanks.

Regards,
-Denis

