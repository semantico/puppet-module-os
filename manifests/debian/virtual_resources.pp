class os::debian::virtual_resources {
    include os::debian::virtual_resources::users
    include os::debian::virtual_resources::groups
    include os::debian::virtual_resources::packages
}
