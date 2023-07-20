let jquery_datatable = $('#table1').DataTable();

const setTableColor = () => {
    document.querySelectorAll('.dataTables_paginate .pagination').forEach(dt => {
        dt.classList.add('pagination-primary')
    })
}
setTableColor()
jquery_datatable.on('draw', setTableColor)

/* $('#categoryDataTable').DataTable({
    processing: true,
    language: {
        loadingRecords: '&nbsp;',
        processing:
        "<img src='/includes/img/loader.gif' height='80' width='80' class='img-fluid'>Loading ...",
    },
    serverSide: true,
    pageLength: 10,
    retrieve: true,
    pagination: 'datatablePagination',
    order: [[0, 'desc']],
    responsive: true,
    dom: 'Blfrtip',
});
 */