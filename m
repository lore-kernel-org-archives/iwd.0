Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3EC63C1
	for <iwd@lists.linux.dev>; Wed,  8 Nov 2023 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpTbjGMT"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ccbb7f79cdso27782325ad.3
        for <iwd@lists.linux.dev>; Wed, 08 Nov 2023 04:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699447343; x=1700052143; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/pgnxkUu1HWjv5Y1u1sryavTnt+eOXDJ1YhgiZvWC0=;
        b=LpTbjGMTZ1V6nMdvlNIvbu7+XfV8blly8lnTQ1SjX19PNE4A45sJEaQsZjTq3LSQjw
         5SlAmgCS1ZFnlo3uSgMbwdEBzjhCgUVUMHuloyZmKP3fXF9976To+reBCpsHtfzS8eNe
         pfXvxHSKHxdGs/M5GXIA6O49mdZ54pQlrFzam9WxNTa32EF09aBMrvEYsHBFofG5Wvtg
         FjWbpvN71da3XCR6jY2ZVrfROemV1WN8GR6sQ0TIllNgbLImn6xz7NKeZUVX9nB+Y0Fy
         P4J4eGimjDuLo01ryE7cSOLBATjsAHPf6SJZwybppWeaGjkKE7eLOzrI42gneGPnhrOK
         kMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699447343; x=1700052143;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/pgnxkUu1HWjv5Y1u1sryavTnt+eOXDJ1YhgiZvWC0=;
        b=NCiWSv6MSybVmgIFnwVwS3pn7HYQKQXHmSKEmealUGpOZuVzySFmw36kiwLqatXjp0
         FVpK/Lx/DlCjlfRGbjm0tV4zMkWhMZQb/zsIl9rvUnrE6CyJZSB36CrhNu4z9lRkFdlJ
         W2Je9KccG/U5aKhqDSgqYEV427ilJ7d7FQeS+GlCjbrqfDFIlYU/Fdr6TgM9k7CtQXH9
         O3fzOw17qpA4irmhfuXChzvPEwbObRB3Yr+pUk4SK70WtaBROx66E506y6/ZPlQiqhMc
         jx0rqee3NlEFHXsDUECtcSReKjTeYChmn8m8tNdbVogRoTfV4YUzuPUmE6AI/U4Rh3e2
         PsWw==
X-Gm-Message-State: AOJu0YzgkEW334lwwLpukB7upH2+qldoxq/mf50F8CWfGb03Slfs5iMC
	IgP0hbZ1Sc1aZ98yL4Vq3QOlU+bJbBk=
X-Google-Smtp-Source: AGHT+IFqEBSt01l/C5qU90wIAjpNHHewpV/2Ekf3VvP7/CVJn1VdyfBl8HiCVAepV+F55+OtT66M6A==
X-Received: by 2002:a17:903:1212:b0:1cc:2bd9:1b2d with SMTP id l18-20020a170903121200b001cc2bd91b2dmr2081574plh.43.1699447343475;
        Wed, 08 Nov 2023 04:42:23 -0800 (PST)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001c735421215sm1659876plb.216.2023.11.08.04.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 04:42:23 -0800 (PST)
Message-ID: <c93871c0-f090-4e7c-9e59-6298113d77bb@gmail.com>
Date: Wed, 8 Nov 2023 04:42:21 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dpp: initial version of PKEX enrollee support
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231107170629.1831655-1-prestwoj@gmail.com>
 <20231107170629.1831655-3-prestwoj@gmail.com>
 <a9c1e09e-97be-47cf-9ea5-b595ac979b2d@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <a9c1e09e-97be-47cf-9ea5-b595ac979b2d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 11/7/23 7:11 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 11/7/23 11:06, James Prestwood wrote:
>> This is the initial support for PKEX enrollees acting as the
>> initiator. A PKEX initiator starts the protocol by broadcasting
>> the PKEX exchange request. This request contains a key encrypted
>> with the pre-shared PKEX code. If accepted the peer sends back
>> the exchange response with its own encrypted key. The enrollee
>> decrypts this and performs some crypto/hashing in order to establish
>> an ephemeral key used to encrypt its own boostrapping key. The
>> boostrapping key is encrypted and sent to the peer in the PKEX
>> commit-reveal request. The peer then does the same thing, encrypting
>> its own bootstrapping key and sending to the initiator as the
>> PKEX commit-reveal response.
>>
>> After this, both peers have exchanged their boostrapping keys
>> securely and can begin DPP authentication, then configuration.
>>
>> For now the enrollee will only iterate the default channel list
>> from the Easy Connect spec. Future upates will need to include some
>> way of discovering non-default channel configurators, but the
>> protocol needs to be ironed out first.
>> ---
>>   src/dpp.c | 792 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 788 insertions(+), 4 deletions(-)
>>
> 
> <snip>
> 
>> +static bool dpp_pkex_get_started(struct l_dbus *dbus,
>> +                struct l_dbus_message *message,
>> +                struct l_dbus_message_builder *builder,
>> +                void *user_data)
>> +{
>> +    struct dpp_sm *dpp = user_data;
>> +    bool started = false;
>> +
>> +    switch (dpp->state) {
>> +    case DPP_STATE_PKEX_EXCHANGE:
>> +    case DPP_STATE_PKEX_COMMIT_REVEAL:
> 
> So what about other states like DPP_STATE_AUTHENTICATING?
> 
>> +        started = true;
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +
>> +    l_dbus_message_builder_append_basic(builder, 'b', &started);
>> +
>> +    return true;
>> +}
>> +
>>   static bool dpp_get_started(struct l_dbus *dbus,
>>                   struct l_dbus_message *message,
>>                   struct l_dbus_message_builder *builder,
>>                   void *user_data)
>>   {
>>       struct dpp_sm *dpp = user_data;
>> -    bool started = (dpp->state != DPP_STATE_NOTHING);
>> +    bool started = false;
>> +
>> +    switch (dpp->state) {
>> +    case DPP_STATE_PRESENCE:
>> +    case DPP_STATE_AUTHENTICATING:
>> +    case DPP_STATE_CONFIGURING:
>> +        started = true;
>> +        break;
>> +    default:
>> +        break;
>> +    }
> Since you're sharing the DPP state machine object between the two 
> interfaces, it seems like starting PKEX on the SharedCode interface 
> side-effects the state of the regular DeviceProvisioning interface?  I 
> hope that's not intended?

Your right, it does. Once PKEX finishes it starts DPP on the 
DeviceProvisioning interface. This was intended, but if we want to keep 
the two isolated I'll have to change gears and think about how we can do it.

May have to create a dpp_sm for each DBus interface not per-wdev/netdev, 
and find some way of communicating which interface the property changed 
calls correspond to.

Apart from the string/cast comments the rest seem to revolve around the 
shared state between PKEX/DPP. If separating them is the way we want to 
go I can do that.

> 
>>       l_dbus_message_builder_append_basic(builder, 'b', &started);
>> @@ -199,7 +249,9 @@ static bool dpp_get_uri(struct l_dbus *dbus,
>>   {
>>       struct dpp_sm *dpp = user_data;
>> -    if (dpp->state == DPP_STATE_NOTHING)
>> +    if (dpp->state == DPP_STATE_NOTHING ||
>> +            dpp->state == DPP_STATE_PKEX_EXCHANGE ||
>> +            dpp->state == DPP_STATE_PKEX_COMMIT_REVEAL)
> 
> So what if PKEX is started and proceeds to the AUTHENTICATING state?
> 
>>           return false;
>>       l_dbus_message_builder_append_basic(builder, 's', dpp->uri);
> 
> <snip>
> 
>> @@ -321,6 +419,7 @@ static void dpp_reset(struct dpp_sm *dpp)
>>       dpp->new_freq = 0;
>>       dpp->frame_retry = 0;
>>       dpp->frame_cookie = 0;
>> +    dpp->pkex_version = 0;
>>       explicit_bzero(dpp->r_nonce, dpp->nonce_len);
>>       explicit_bzero(dpp->i_nonce, dpp->nonce_len);
>> @@ -329,10 +428,15 @@ static void dpp_reset(struct dpp_sm *dpp)
>>       explicit_bzero(dpp->k1, dpp->key_len);
>>       explicit_bzero(dpp->k2, dpp->key_len);
>>       explicit_bzero(dpp->auth_tag, dpp->key_len);
>> +    explicit_bzero(dpp->z, dpp->key_len);
>> +    explicit_bzero(dpp->u, dpp->u_len);
>> +
>> +    dpp_free_pending_pkex_data(dpp);
>>       dpp_free_auth_data(dpp);
>>       dpp_property_changed_notify(dpp);
>> +    dpp_pkex_property_changed_notify(dpp);
> 
> So are you emitting PropertyChanged on all interfaces, regardless 
> whether that interface was actually involved in an operation?
> 
>>   }
>>   static void dpp_free(struct dpp_sm *dpp)
>> @@ -357,6 +461,23 @@ static void dpp_free(struct dpp_sm *dpp)
>>       l_free(dpp);
>>   }
>> +static bool dpp_check_pkex_identifier(const char *id)
>> +{
>> +    const char *end;
>> +
>> +    if (!id)
>> +        return true;
>> +
>> +    /*
>> +     * "If an optional code identifier is used, it shall be a UTF-8 
>> string
>> +     *  not greater than eighty (80) octets"
>> +     */
>> +    if (!l_utf8_validate(id, strlen(id), &end) || end - id > 80)
> 
> Any strings obtained over d-bus must already be valid utf8 and cannot be 
> NULL. You seem to call this function only from dpp_parse_pkex_args()?  I 
> would have thought you'd be calling it from the DPP message parser?
> 
>> +        return false;
>> +
>> +    return true;
>> +}
>> +
>>   static void dpp_send_frame_cb(struct l_genl_msg *msg, void *user_data)
>>   {
>>       struct dpp_sm *dpp = user_data;
>> @@ -1512,6 +1633,71 @@ static bool 
>> dpp_send_authenticate_request(struct dpp_sm *dpp)
>>       return true;
>>   }
>> +static void dpp_send_pkex_exchange_request(struct dpp_sm *dpp)
>> +{
>> +    uint8_t hdr[32];
>> +    uint8_t attrs[256];
>> +    uint8_t *ptr = attrs;
>> +    uint64_t m_data[L_ECC_MAX_DIGITS * 2];
>> +    uint16_t group;
>> +    struct iovec iov[2];
>> +    const uint8_t *own_mac = netdev_get_address(dpp->netdev);
>> +
>> +    l_put_le16(l_ecc_curve_get_ike_group(dpp->curve), &group);
>> +
>> +    iov[0].iov_len = dpp_build_header(own_mac, broadcast,
>> +                DPP_FRAME_PKEX_VERSION1_XCHG_REQUST, hdr);
> 
> Looks like there's a typo here, 'REQUST'
> 
>> +    iov[0].iov_base = hdr;
>> +
>> +    ptr += dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION,
>> +                &dpp->pkex_version, 1);
>> +    ptr += dpp_append_attr(ptr, DPP_ATTR_FINITE_CYCLIC_GROUP,
>> +                &group, 2);
>> +
>> +    if (dpp->pkex_id)
>> +        ptr += dpp_append_attr(ptr, DPP_ATTR_CODE_IDENTIFIER,
>> +                    dpp->pkex_id, strlen(dpp->pkex_id));
>> +
>> +    l_ecc_point_get_data(dpp->pkex_m, m_data, sizeof(m_data));
>> +
>> +    ptr += dpp_append_attr(ptr, DPP_ATTR_ENCRYPTED_KEY,
>> +                m_data, dpp->key_len * 2);
>> +
>> +    iov[1].iov_base = attrs;
>> +    iov[1].iov_len = ptr - attrs;
>> +
>> +    dpp_send_frame(dpp, iov, 2, dpp->current_freq);
>> +}
>> +
>> +static void dpp_send_commit_reveal_request(struct dpp_sm *dpp)
>> +{
>> +    struct iovec iov[2];
>> +    uint8_t hdr[41];
>> +    uint8_t attrs[512];
>> +    uint8_t *ptr = attrs;
>> +    uint8_t zero = 0;
>> +    uint8_t a_pub[L_ECC_POINT_MAX_BYTES];
>> +    ssize_t a_len;
>> +
>> +    a_len = l_ecc_point_get_data(dpp->boot_public, a_pub, 
>> sizeof(a_pub));
>> +
>> +    iov[0].iov_len = dpp_build_header(netdev_get_address(dpp->netdev),
>> +                    dpp->peer_addr,
>> +                    DPP_FRAME_PKEX_COMMIT_REVEAL_REQUEST,
>> +                    hdr);
>> +    iov[0].iov_base = hdr;
>> +
>> +    ptr += dpp_append_wrapped_data(hdr + 26, 6, &zero, 1, ptr,
>> +            sizeof(attrs), dpp->z, dpp->z_len, 2,
>> +            DPP_ATTR_BOOTSTRAPPING_KEY, a_len, a_pub,
>> +            DPP_ATTR_INITIATOR_AUTH_TAG, dpp->u_len, dpp->u);
>> +
>> +    iov[1].iov_base = attrs;
>> +    iov[1].iov_len = ptr - attrs;
>> +
>> +    dpp_send_frame(dpp, iov, 2, dpp->current_freq);
>> +}
>> +
>>   static void dpp_roc_started(void *user_data)
>>   {
>>       struct dpp_sm *dpp = user_data;
> 
> <snip>
> 
>> +static void dpp_handle_pkex_exchange_response(struct dpp_sm *dpp,
>> +                    const uint8_t *from,
>> +                    const uint8_t *body, size_t body_len)
>> +{
>> +    struct dpp_attr_iter iter;
>> +    enum dpp_attribute_type type;
>> +    size_t len;
>> +    const uint8_t *data;
>> +    const uint8_t *status = NULL;
>> +    uint8_t version = 0;
>> +    const char *identifier = NULL;
>> +    size_t identifier_len = 0;
>> +    const void *key = NULL;
>> +    size_t key_len = 0;
>> +    uint16_t group = 0;
>> +    _auto_(l_ecc_point_free) struct l_ecc_point *n = NULL;
>> +    _auto_(l_ecc_point_free) struct l_ecc_point *j = NULL;
>> +    _auto_(l_ecc_point_free) struct l_ecc_point *qr = NULL;
>> +    _auto_(l_ecc_point_free) struct l_ecc_point *k = NULL;
>> +    const uint8_t *own_addr = netdev_get_address(dpp->netdev);
>> +
>> +    l_debug("PKEX response "MAC, MAC_STR(from));
>> +
>> +    if (dpp->state != DPP_STATE_PKEX_EXCHANGE)
>> +        return;
>> +
>> +    if (dpp->role != DPP_CAPABILITY_ENROLLEE)
>> +        return;
>> +
>> +    memcpy(dpp->peer_addr, from, 6);
>> +
>> +    dpp_attr_iter_init(&iter, body + 8, body_len - 8);
>> +
>> +    while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
>> +        switch (type) {
>> +        case DPP_ATTR_STATUS:
>> +            if (len != 1)
>> +                return;
>> +
>> +            status = data;
>> +            break;
>> +        case DPP_ATTR_PROTOCOL_VERSION:
>> +            if (len != 1)
>> +                return;
>> +
>> +            version = l_get_u8(data);
>> +            break;
>> +        case DPP_ATTR_CODE_IDENTIFIER:
>> +            identifier = (char *) data;
>> +            identifier_len = len;
> 
> Is data guaranteed to be null terminated?  Also, this cast seems fishy.  
> Why not const char?  You can't scribble into this buffer...
> 
>> +            break;
>> +        case DPP_ATTR_ENCRYPTED_KEY:
>> +            if (len != dpp->key_len * 2)
>> +                return;
>> +
>> +            key = data;
>> +            key_len = len;
>> +            break;
>> +        case DPP_ATTR_FINITE_CYCLIC_GROUP:
>> +            if (len != 2)
>> +                return;
>> +
>> +            group = l_get_le16(data);
>> +            break;
>> +        default:
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (!status) {
>> +        l_debug("No status attribute, ignoring");
>> +        return;
>> +    }
>> +
>> +    if (!key) {
>> +        l_debug("No encrypted key, ignoring");
>> +        return;
>> +    }
>> +
>> +    if (*status != DPP_STATUS_OK)
>> +        goto handle_status;
>> +
>> +    if (dpp->pkex_id) {
>> +        if (!identifier || identifier_len != strlen(dpp->pkex_id) ||
>> +                    strncmp(dpp->pkex_id, identifier,
>> +                        identifier_len)) {
> 
> No point in using strncmp there if you just compared the lengths.  Just 
> use memcpy instead.  Compiler warnings have made strncmp and strncpy 
> nearly useless.
> 
>> +            l_debug("mismatch identifier, ignoring");
>> +            return;
>> +        }
>> +    }
>> +
>> +    if (version && version != dpp->pkex_version) {
>> +        l_debug("PKEX version does not match, igoring");
>> +        return;
>> +    }
>> +
>> +    n = l_ecc_point_from_data(dpp->curve, L_ECC_POINT_TYPE_FULL,
>> +                    key, key_len);
>> +    if (!n) {
>> +        l_debug("failed to parse peers encrypted key");
>> +        goto failed;
>> +    }
>> +
>> +    qr = dpp_derive_qr(dpp->curve, dpp->pkex_key, dpp->pkex_id,
>> +                dpp->peer_addr);
>> +    if (!qr)
>> +        goto failed;
>> +
>> +    dpp->y_or_x = l_ecc_point_new(dpp->curve);
>> +
>> +    /* Y' = N - Qr */
>> +    l_ecc_point_inverse(qr);
>> +    l_ecc_point_add(dpp->y_or_x, n, qr);
>> +
>> +    /*
>> +     * "The resulting ephemeral key, denoted Y’, is then checked 
>> whether it
>> +     * is the point-at-infinity. If it is not valid, the protocol ends
>> +     * unsuccessfully"
>> +     */
>> +    if (l_ecc_point_is_infinity(dpp->y_or_x)) {
>> +        l_debug("Y' computed to infinity, failing");
>> +        goto failed;
>> +    }
>> +
>> +    k = l_ecc_point_new(dpp->curve);
>> +
>> +    /* K = Y' * x */
>> +    l_ecc_point_multiply(k, dpp->pkex_private, dpp->y_or_x);
>> +
>> +    dpp_derive_z(own_addr, dpp->peer_addr, n, dpp->pkex_m, k,
>> +                dpp->pkex_key, dpp->pkex_id,
>> +                dpp->z, &dpp->z_len);
>> +
>> +    /* J = a * Y' */
>> +    j = l_ecc_point_new(dpp->curve);
>> +
>> +    l_ecc_point_multiply(j, dpp->boot_private, dpp->y_or_x);
>> +
>> +    if (!dpp_derive_u(j, own_addr, dpp->boot_public, dpp->y_or_x,
>> +                dpp->pkex_public, dpp->u, &dpp->u_len)) {
>> +        l_debug("failed to compute u");
>> +        goto failed;
>> +    }
>> +
>> +    /*
>> +     * Now that a response was successfully received, start another
>> +     * offchannel with more time for the remainder of the protocol. 
>> After
>> +     * PKEX, authentication will begin which handles the protocol 
>> timeout.
>> +     * If the remainder of PKEX (commit-reveal exchange) cannot 
>> complete in
>> +     * this time it will fail.
>> +     */
>> +    dpp->dwell = (dpp->max_roc < 2000) ? dpp->max_roc : 2000;
>> +    dpp->state = DPP_STATE_PKEX_COMMIT_REVEAL;
>> +
>> +    dpp_pkex_property_changed_notify(dpp);
>> +
>> +    dpp_start_offchannel(dpp, dpp->current_freq);
>> +
>> +    return;
>> +
>> +handle_status:
>> +    switch (*status) {
>> +    case DPP_STATUS_BAD_GROUP:
>> +        dpp_pkex_bad_group(dpp, group);
>> +        break;
>> +    case DPP_STATUS_BAD_CODE:
>> +        dpp_pkex_bad_code(dpp);
>> +        break;
>> +    default:
>> +        l_debug("Unhandled status %u", *status);
>> +        break;
>> +    }
>> +
>> +failed:
>> +    dpp_reset(dpp);
>> +}
>> +
>> +static bool dpp_pkex_start_authentication(struct dpp_sm *dpp)
>> +{
>> +    dpp->uri = dpp_generate_uri(dpp->own_asn1, dpp->own_asn1_len, 2,
>> +                    netdev_get_address(dpp->netdev),
>> +                    &dpp->current_freq, 1, NULL, NULL);
>> +
>> +    l_ecdh_generate_key_pair(dpp->curve, &dpp->proto_private,
>> +                    &dpp->own_proto_public);
>> +
>> +    l_getrandom(dpp->i_nonce, dpp->nonce_len);
>> +
>> +    dpp->peer_asn1 = dpp_point_to_asn1(dpp->peer_boot_public,
>> +                        &dpp->peer_asn1_len);
>> +
>> +    dpp->m = dpp_derive_k1(dpp->peer_boot_public, dpp->proto_private,
>> +                dpp->k1);
>> +
>> +    dpp_hash(L_CHECKSUM_SHA256, dpp->peer_boot_hash, 1, dpp->peer_asn1,
>> +            dpp->peer_asn1_len);
>> +
>> +    dpp->state = DPP_STATE_AUTHENTICATING;
> 
> So you go into the authenticating state even in PKEX.  But now this 
> state might be reflected in any property GetAll/Get calls on the 
> DeviceProvisioning interface...
> 
>> +    dpp->mutual_auth = true;
>> +
>> +    dpp_pkex_property_changed_notify(dpp);
>> +
>> +    if (dpp->role == DPP_CAPABILITY_ENROLLEE) {
>> +        dpp->new_freq = dpp->current_freq;
>> +
>> +        return dpp_send_authenticate_request(dpp);
>> +    }
>> +
>> +    return true;
>> +}
>> +
> 
> <snip>
> 
>> @@ -2435,6 +3023,8 @@ static void dpp_create(struct netdev *netdev)
>>       l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
>>                       IWD_DPP_INTERFACE, dpp);
>> +    l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
>> +                    IWD_DPP_PKEX_INTERFACE, dpp);
> 
> Looks like dpp interfaces share the same underlying object...
> 
>>       dpp_frame_watch(dpp, 0x00d0, dpp_prefix, sizeof(dpp_prefix));
>> @@ -2730,9 +3320,176 @@ static struct l_dbus_message 
>> *dpp_dbus_stop(struct l_dbus *dbus,
>>   {
>>       struct dpp_sm *dpp = user_data;
>> +    /* Don't stop PKEX from the DPP interface */
>> +    if (!dpp->pkex_version)
>> +        dpp_reset(dpp);
>> +
>> +    return l_dbus_message_new_method_return(message);
>> +}
>> +
>> +/*
>> + * Section 5.6.1
>> + * In lieu of specific channel information obtained in a manner outside
>> + * the scope of this specification, PKEX responders shall select one of
>> + * the following channels:
>> + *  - 2.4 GHz: Channel 6 (2.437 GHz)
>> + *  - 5 GHz: Channel 44 (5.220 GHz) if local regulations permit
>> + *           operation only in the 5.150 – 5.250 GHz band and Channel
>> + *           149 (5.745 GHz) otherwise
>> + */
>> +static uint32_t *dpp_default_freqs(struct dpp_sm *dpp, size_t *out_len)
>> +{
>> +    struct wiphy *wiphy = wiphy_find_by_wdev(dpp->wdev_id);
>> +    const uint32_t default_channels[] = { 2437, 5220, 5745 };
>> +    uint32_t *freqs_out;
>> +    size_t i;
>> +    size_t len = 1;
>> +
>> +    if (wiphy_get_supported_bands(wiphy) & BAND_FREQ_5_GHZ)
>> +        len += 2;
> 
> Is 2.4GHz band support check needed?
> 
>> +
>> +    freqs_out = l_new(uint32_t, len);
>> +
>> +    for (i = 0; i < 3; i++)
>> +        freqs_out[i] = default_channels[i];
>> +
>> +    *out_len = len;
>> +    return freqs_out;
>> +}
>> +
> 
> Regards,
> -Denis
