Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AE53D989
	for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdh35gdT"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-66d24ccc6f2so21126346d6.0
        for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 14:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698357185; x=1698961985; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lKbw+UcHiq9r0x+5AYX6UPToanY/QTr51a+OQt/h0zg=;
        b=kdh35gdT0YQmgSEoPOBaVs32qpVTkYHIt8qS4e4Y8JUwWNCvqVrjxvcOhH+RFbO3Je
         nv2UpuWAbzfE55aM38zH5wfMcbzhxTLOfoO4AGn7Lf3VG6JupUkTF1ynVTj7HXzaqdmX
         JEWqKIjG4IzpBZtMv4+vSZM9RJTdE7sHcsfwS7zTZ/0yhkfykRQ74PML9YHlSiDaF/zR
         131Xm5yeunZU7/L8NdYIrLKVFBZKnNfxcJmw75M+dwyo7nOk7rXZYxTHrXi2Oz8MDksz
         voPv7lNvvAvDAZ1ZVFEI48ExfkSCywcE/YHqbcJW0sVelqek+crDqHBeU4UwfFvXqsvT
         3PZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698357185; x=1698961985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKbw+UcHiq9r0x+5AYX6UPToanY/QTr51a+OQt/h0zg=;
        b=Pmh5yerNL8T2Awegxmr7l7D3w1wcEyH+J5/OYYzsna5EIKumcPdh0CnIo0i7EVVy4C
         t43dn06W/mxF14EY5qqKPwT8PbiryXlV19+2o4tUWIGpn7EMDc4v5vAPaY1cNda6OwLh
         omCTNk0fLHLpgBxASx9cjq+n42pr+UGs7jQgeoMEr02lzhtJPrgj1+knyzqn0ZXZIdI5
         o3RnBEM2kEnO0nj8EyjZF+Y0E/6YGbLOEnS6p3jWzV/citme1ptF+OpBmK1SfRl/8qO2
         kd5410W3d0vgH3pJu8ISizouw30zTeWCvIpGvmzMn3hQix5iq8zxe1UDy4BALSjoKCi+
         pVog==
X-Gm-Message-State: AOJu0YzrmDOVrx90hDTz58oYWIlymK5EkcfqS8KGJ6ObTcBjPMRPe/bQ
	phDwDVjuZPm2XIwxfWMqVy5OumjGePM=
X-Google-Smtp-Source: AGHT+IGO9kRjd8ZOAnq3C87XNHUQkzLls8URAh1YUzUWU0uCT82FEjD/cC6a9Bii4xVcF5qFcFszCw==
X-Received: by 2002:a05:6214:4988:b0:66c:fa89:a894 with SMTP id pf8-20020a056214498800b0066cfa89a894mr5249140qvb.10.1698357185197;
        Thu, 26 Oct 2023 14:53:05 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id m14-20020a0ce8ce000000b0066d11743b3esm120382qvo.34.2023.10.26.14.53.04
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 14:53:04 -0700 (PDT)
Message-ID: <5b66ced2-2737-4b47-8d83-5de4dbf9a968@gmail.com>
Date: Thu, 26 Oct 2023 14:53:02 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] dpp: fix config request header check
To: iwd@lists.linux.dev
References: <20231026202657.183591-1-prestwoj@gmail.com>
 <20231026202657.183591-6-prestwoj@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20231026202657.183591-6-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/23 1:26 PM, James Prestwood wrote:
> The check for the header was incorrect according to the spec.
> Table 58 indicates that the "Query Response Info" should be set
> to 0x00 for the configuration request. The frame handler was
> expecting 0x7f which is the value for the config response frame.
> 
> Unfortunately wpa_supplicant also gets this wrong and uses 0x7f
> in all cases which is likely why this value was set incorrectly
> in IWD. The issue is that IWD's config request is correct which
> means IWD<->IWD configuration is broken. (and wpa_supplicant as
> a configurator likely doesn't validate the config request).
> 
> Fix this by checking both 0x7f and 0x00 to handle both
> supplicants.
> ---
>   src/dpp.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/src/dpp.c b/src/dpp.c
> index dff0ecaf..6fd37272 100644
> --- a/src/dpp.c
> +++ b/src/dpp.c
> @@ -887,6 +887,21 @@ static void dpp_send_config_response(struct dpp_sm *dpp, uint8_t status)
>   	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
>   }
>   
> +static bool dpp_check_config_header(const uint8_t *ptr)
> +{
> +	/*
> +	 * Table 58. General Format of DPP Configuration Request frame
> +	 *
> +	 * Unfortunately wpa_supplicant hard codes 0x7f as the Query Response
> +	 * Info so we need to handle both cases.
> +	 */
> +	return ptr[0] != IE_TYPE_ADVERTISEMENT_PROTOCOL ||
> +			ptr[1] != 0x08 ||
> +			(ptr[2] != 0x7f || ptr[2] != 0x00) ||
> +			ptr[3] != IE_TYPE_VENDOR_SPECIFIC ||
> +			ptr[4] != 5;
> +}

I somehow got this logic completely backwards. This will always be true, 
will send v2 after any review comments.

> +
>   static void dpp_handle_config_request_frame(const struct mmpdu_header *frame,
>   				const void *body, size_t body_len,
>   				int rssi, void *user_data)
> @@ -904,8 +919,6 @@ static void dpp_handle_config_request_frame(const struct mmpdu_header *frame,
>   	const uint8_t *e_nonce = NULL;
>   	size_t wrapped_len = 0;
>   	_auto_(l_free) uint8_t *unwrapped = NULL;
> -	uint8_t hdr_check[] = { IE_TYPE_ADVERTISEMENT_PROTOCOL, 0x08, 0x7f,
> -				IE_TYPE_VENDOR_SPECIFIC, 5 };
>   	struct json_iter jsiter;
>   	_auto_(l_free) char *tech = NULL;
>   	_auto_(l_free) char *role = NULL;
> @@ -932,10 +945,10 @@ static void dpp_handle_config_request_frame(const struct mmpdu_header *frame,
>   
>   	dpp->diag_token = *ptr++;
>   
> -	if (memcmp(ptr, hdr_check, sizeof(hdr_check)))
> +	if (!dpp_check_config_header(ptr))
>   		return;
>   
> -	ptr += sizeof(hdr_check);
> +	ptr += 5;
>   
>   	if (memcmp(ptr, wifi_alliance_oui, sizeof(wifi_alliance_oui)))
>   		return;
